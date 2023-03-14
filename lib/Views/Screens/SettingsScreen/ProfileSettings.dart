import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String _url = 'https://fix-era.com/';

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Please go to website and update \n    your Profile settings there",style: TextStyle(fontSize: 14,color: Colors.grey),textAlign: TextAlign.justify,),
          ),
        ),
        GestureDetector(
          onTap: () {
            _launchURL();
          },

          child: Text("Go to Website",style: TextStyle(color: Colors.black),),
        )
      ],
    );
  }
}
