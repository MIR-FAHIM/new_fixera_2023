


import 'package:flutter/material.dart';
import 'package:platform/platform.dart';
import 'package:flutter/cupertino.dart';

import 'package:url_launcher/url_launcher.dart';

class Alerts {
  static Future<void> show(context, title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  static Future<void> rateAppDialouge(context, title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            Column(
                children:[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        TextButton(
                          child: Text("Camera",style: TextStyle(fontWeight: FontWeight.bold),),
                          onPressed: () {

                          },
                        ),
                        TextButton(
                          child: Text("Gallery", style: TextStyle(fontWeight: FontWeight.bold),),
                          onPressed: () {

                          },
                        ),
                      ]
                  ),

                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]
            ),
          ],
        );
      },
    );
  }


}
