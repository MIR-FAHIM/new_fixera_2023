import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {

  final String title;
  TextFieldTitle(this.title);
   @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Align(
          alignment: Alignment.topLeft,
          child: RichText(text: TextSpan(
              children: [
                TextSpan(text: "${title }:", style: TextStyle(color: Colors.black87, fontSize: 16)),
                TextSpan(text: " *", style: TextStyle(color: Colors.red)),
              ]
          )),
        )
    );
  }
}
