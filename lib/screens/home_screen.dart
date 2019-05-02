import 'package:flutter/material.dart';
import 'single_filter_screen.dart';
import 'sequence_filter_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildImageBackground(),
          _buildGradientLayer(),
          _buildBody(),
        ],
      )
    );
  }

  Widget _buildAppName(){
    return Container(
      child: Text(
        "ART FILTER",
        style: TextStyle(
          fontFamily: "LittleBird",
          fontWeight: FontWeight.w900,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _buildImageBackground(){
    return Opacity(
      opacity: 0.2,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background/background.jpg')
          )
        ),
      ),
    );
  }

  Widget _buildGradientLayer(){
    return Opacity(
      opacity: 0.7,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: 
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.pink,
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildBody(){
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height*0.15,
          ),
          _buildAppName(),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.3,
          ),
          _buildSingleModeButton(),
           SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
          ),
          _buildSquenceModeButton(),
        ],
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildSingleModeButton(){
    return Center(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Mono mode",
            style: TextStyle(
              fontFamily: "LittleBird",
              fontSize: 15,
              fontWeight: FontWeight.w900,
            )
          ),
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width*0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.pink[200]),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        onTap: ()async{
          SingleFilterScreen singleFilterScreen = SingleFilterScreen();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => singleFilterScreen),
          );
        },
      )
    );
  }

  Widget _buildSquenceModeButton(){
    return Center(
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Sequence mode",
            style: TextStyle(
              fontFamily: "LittleBird",
              fontSize: 15,
              fontWeight: FontWeight.w900,
            )
          ),
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width*0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.pink[200]),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        onTap: ()async{
          Widget sequenceFilterScreen = SequenceFilterScreen();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sequenceFilterScreen),
          );
        },
      )
    );
  }

}
