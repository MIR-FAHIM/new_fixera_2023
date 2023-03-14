import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:new_fixera/main.dart';

class PostOrLeadFlutterScreen extends StatefulWidget {
  @override
  _PostOrLeadFlutterScreenState createState() =>
      _PostOrLeadFlutterScreenState();
}

class _PostOrLeadFlutterScreenState extends State<PostOrLeadFlutterScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 30,
            child: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
          elevation: 8,
          onPressed: () async {},
        ),
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: userMap!["user_info"]["role_name"] == "vendor"
              ? Text("Leads")
              : Text("Projects"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            // controller: tabController,
            tabs: [
              Tab(text: "Manage"),
              Tab(text: "Ongoing"),
              Tab(text: "Completed")
            ],
          ),
        ),

        body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400]
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Text("Manage Projects"),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.green
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width*0.85,
                                      color: Colors.grey[100],
                                      child: Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Text("Posted Projects"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[400]
              ),
              child: Text("Ongoing"),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[400]
              ),
              child: Text("Completed"),
            )
          ],
        )

      ),
    );
  }
}
