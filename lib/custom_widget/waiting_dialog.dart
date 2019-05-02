import 'package:flutter/material.dart';

class WaitingDialog extends StatefulWidget {
  final Future<void> processingFunction;
  final Function errorHandle;

  WaitingDialog({this.processingFunction, this.errorHandle});
   @override
  _WaitingDialogState createState() => _WaitingDialogState();
}

class _WaitingDialogState extends State<WaitingDialog> {
  @override
  void initState() {
    widget.processingFunction.whenComplete((){
        Navigator.of(context).pop();
      }
    ).catchError((e){
        print(e);
        widget.errorHandle();
        // Navigator.of(context).pop();
      }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Text("Please wait for processing"),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Image.asset("assets/images/waiting.gif")
            )
          ]
        ),
      ),
    );
  }
}