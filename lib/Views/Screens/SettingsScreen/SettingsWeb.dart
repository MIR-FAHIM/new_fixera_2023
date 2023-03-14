import 'package:new_fixera/Views/Screens/SettingsScreen/AccountSettings.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/PaymnetSettings.dart';
import 'package:new_fixera/Views/Screens/SettingsScreen/ProfileSettings.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';

class SettingsWebPage extends StatefulWidget {
  SettingsWebPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsWebPage> {
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:AppColors.primaryColor,
          title: Text("Settings"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: false,

            // controller: tabController,
            tabs: [
              Tab(text: "Account"),
              Tab(text: "Profile"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [AccountSettings(), ProfileSettings()],
        ),
      ),
    );
  }
}
