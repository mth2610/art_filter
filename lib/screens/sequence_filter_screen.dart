import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:artistic_style_transfer/artistic_style_transfer.dart';
import 'package:share/share.dart';
import 'package:album_saver/album_saver.dart';
import '../custom_widget/gradient_appbar.dart';
import '../admob_manager.dart';
import '../custom_widget/waiting_dialog.dart';
import '../custom_widget/message_dialog.dart';

// const double _kLeadingWidth = kToolbarHeight;

class SequenceFilterScreen extends StatefulWidget {
  @override
  _SequenceFilterScreenState createState() => _SequenceFilterScreenState();
}

class _SequenceFilterScreenState extends State<SequenceFilterScreen> {
  File _image;
  String _proceessedImage;
  bool _isSaving;
  AdmobManager _admobManager = AdmobManager();

  //filter settings
  int _quality = 40;
  double _styleFactor = 1.0;
  bool _convertToGrey = false;
  bool _saveToDCIM = false;

  List<int> _selectedStyles = [];
  Map<int, bool> _selectedStylesState = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
    11: false,
    12: false,
    13: false,
    14: false,
    15: false,
    16: false,
    17: false,
    18: false,
    19: false,
    20: false,
    21: false,
    22: false,
    23: false,
    24: false,
    25: false,
    26: false,
  };

  @override
  void initState() {
    _admobManager.init()..whenComplete((){
        _admobManager.showBanner();
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    _admobManager.dispose();
    super.dispose();
  }

  void _errorHandle(){
    showDialog(
        context: context,
        barrierDismissible: false,
        child: MessageDialog(title: "Error", message: "Failed to process image, please try again or reduce quality"),
    );
  }

  Future<void> _processImage()async{
    if(_selectedStyles.length==0&&_image!=null){
        showDialog(
            context: context,
            barrierDismissible: false,
            child: MessageDialog(title: "Error", message: "Please select at least one style"),
        );
    } else if(_image==null&&_selectedStyles.length!=0) {
        showDialog(
            context: context,
            barrierDismissible: false,
            child: MessageDialog(title: "Error", message: "Please select input image"),
        );
    } else if(_selectedStyles.length==0&&_image==null){
        showDialog(
            context: context,
            barrierDismissible: false,
            child: MessageDialog(title: "Error", message: "Please select input image and at least one style"),
        );
    }
    else {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      if(_proceessedImage==null){
        _proceessedImage = await ArtisticStyleTransfer.styleTransfer(styles: _selectedStyles, inputFilePath: _image.path, outputFilePath: tempPath, quality: _quality, styleFactor: 1.0, convertToGrey: _convertToGrey);
      } else {
        _proceessedImage = await ArtisticStyleTransfer.styleTransfer(styles: _selectedStyles, inputFilePath: _proceessedImage, outputFilePath: tempPath, quality: _quality, styleFactor: 1.0, convertToGrey: _convertToGrey);
      }
      _quality = 100;
      setState(() {
      });
      if(_saveToDCIM==true){
        AlbumSaver.saveToAlbum(filePath: _proceessedImage, albumName: "ProcessedArtFilterImages");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: _buildDrawer(),
          appBar: GradientAppBar(
            title: const Text('Sequence mode'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: (){
                  if(_proceessedImage!=null){
                    Share.shareFile(File(_proceessedImage));
                  }
                },
              )
            ],
          ),
          body: Builder(
            builder: (BuildContext buildContext){
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  _buildPickedImage(),
                  _buildImagePickerButton(buildContext),
                  // _buildProcessButton(),
                  SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildFilterButtons(),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  )
                ],
              );
            }
          )
        );
  }

  Widget _buildPickedImage(){
    double imageHeight = MediaQuery.of(context).size.height*0.5;
    return _proceessedImage != null
    ? Container(
      margin: EdgeInsets.all(16),
      height: imageHeight,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.pink[100]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: FileImage(File(_proceessedImage)),
          )
        )
    )
    : Container(
      margin: EdgeInsets.all(16),
      height: imageHeight,
      child: _image!=null
        ? null
        : Center(
          child: Container(
            child: Text(
              "No selected image",
              style: TextStyle(
                color: Colors.pink[100]
              ),
            ),
          ),
        ),
      decoration: _image!=null
        ? BoxDecoration(
          border: Border.all(width: 1, color: Colors.pink[100]),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: FileImage(_image),
          )
        )
        : BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.pink[100])
        ),
    );
  }

  Widget _buildImagePickerButton(BuildContext drawerContext){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.pink[200],
            ),
            onPressed: ()async{
              var image = await ImagePicker.pickImage(source: ImageSource.camera);
              setState(() {
                _image = image;
                _proceessedImage = null;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.folder,
              color: Colors.pink[200],
            ),
            onPressed: ()async{
              var image = await ImagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                _image = image;
                _proceessedImage = null;
              });
            },
          ),
          _buildProcessButton(),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.pink[200],
            ),
            onPressed: ()async{
              _selectedStylesState.forEach((key, value){
                _selectedStylesState[key] = false;
              });
              _selectedStyles = [];
              setState(() {
              });
            },
          ),
          _buildOpenDrawerButton(drawerContext)
        ],
      ),
    );
  }

  Widget _buildProcessButton(){
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: 80,
        child: Text(
          "Apply",
          style: TextStyle(
            color: Colors.white
          )
        ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink[300],
            Colors.pink[100],
          ]
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.5, 0.5),
            color: Colors.grey[500],
            blurRadius: 1.0,
            spreadRadius: 1.0,
          )
        ]
      ),
      ),
      onTap:(){
        showDialog(
            context: context,
            barrierDismissible: false,
            child: WaitingDialog(
              processingFunction: _processImage(),
              errorHandle: _errorHandle,
          ),
        );
      },
    );
  }

  List<Widget> _buildFilterButtons(){
    List<Widget> buttons = [];
    for(int i=0; i< 26; i++){
      buttons.add(
        InkWell(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.height*0.15,
                height: MediaQuery.of(context).size.height*0.15,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/styles/style$i.jpg"),
                    fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              _selectedStylesState[i]==true
              ? Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white.withOpacity(0.8),
                ),
                width: MediaQuery.of(context).size.height*0.15,
                height: MediaQuery.of(context).size.height*0.15,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.pink[200].withOpacity(0.8),
                  border: Border.all(width: 1, color: Colors.pink)
                ),
              )
              : Container()
            ],
          ),
          onTap: ()async{
            _selectedStylesState[i]= !_selectedStylesState[i];
            if(_selectedStyles.contains(i)){
              _selectedStyles.remove(i);
            } else {
              _selectedStyles.add(i);
            }
            setState(() {
            });
          },
        )
      );
    }
    return buttons;
  }

  Widget _buildOpenDrawerButton(BuildContext drawerContext){
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.pink[200],
      ),
      onPressed: ()async{
        Scaffold.of(drawerContext).openDrawer();
      },
    );
  }

  Widget _buildDrawer(){
     return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: kToolbarHeight + 90,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pink[300],
                        Colors.pink[100],
                      ]
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      )
                    ]
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: Text(
                "Quality %",
                style: Theme.of(context).textTheme.body2,
              ),
              padding: const EdgeInsets.all(16),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Slider(
                    value: _quality.ceilToDouble(),
                    min: 5.0,
                    max: 100.0,
                    divisions: 19,
                    onChanged: (value){
                      setState(() {
                        _quality = value.toInt();
                      });
                    },
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    "$_quality",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Text(
                "Be awared that higher quality will consume more memory and the app might crash",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Convert to grey",
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: Switch(
                value: _convertToGrey,
                onChanged: (value){
                  setState(() {
                    _convertToGrey = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Save to DCIM folder (ProcessedArtFilterImages)",
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: Switch(
                value: _saveToDCIM,
                onChanged: (value){
                  setState(() {
                    _saveToDCIM = value;
                  });
                },
              ),
            ),
          ]
        )
     );
  }
}