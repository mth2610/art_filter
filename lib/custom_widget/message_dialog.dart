import 'package:flutter/material.dart';

class MessageDialog extends StatefulWidget {
  final String title;
  final String message;
  MessageDialog({this.title, this.message});
   @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {

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
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text("${widget.message}"),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  child: Text(
                    "OK",
                    style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
                        offset: Offset(0.1, 0.1),
                        color: Colors.grey[500],
                        blurRadius: 0.5,
                        spreadRadius: 0.5,
                      )
                    ]
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}