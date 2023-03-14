import 'dart:io';
import 'package:new_fixera/Controller/SettingsController.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppDimension.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettignsController settingsController = Get.find();
  TextEditingController fname = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController longitute = TextEditingController();
  TextEditingController latituate = TextEditingController();
  TextEditingController noOfEmployees = TextEditingController();
  File? profile, banner;
  String? p;
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                      //  settingsController.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                     // settingsController.imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${userMap!["user_info"]["banner"]}");
    fname.text = "  ${userMap!["user_info"]["first_name"]}";
    lName.text = "  ${userMap!["user_info"]["last_name"]}";
    country.text = "   ${userMap!["user_info"]["country"]}";
    longitute.text = "  ${userMap!["user_info"]["longitude"]}";
    latituate.text = "  ${userMap!["user_info"]["latitude"]}";
    address.text = "  ${userMap!["user_info"]["address"]}";
    p = userMap!["user_info"]["avatar"];
    print(p);
    // settingsController.profile=File(p);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      backgroundColor: Color(0xffDCDCDC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: Container(
                    child: GetBuilder<SettignsController>(
                      builder: (settingsController) {
                        print("this is view ${settingsController.banner}");
                        return settingsController.isBnNetwork == false
                            ? Image.file(
                                settingsController.banner!,
                                height: 250,
                                width: Get.width,
                                fit: BoxFit.fill,
                              )
                            : settingsController.isBnNetwork == true
                                ? Image.network(
                                    settingsController.bannerString!,
                                    height: 250,
                                    width: Get.width,
                                  )
                                : Container(
                                    color: Color(0xff707070),
                                    height: 250,
                                    width: Get.width,
                                  );
                      },
                    ),
                    //color: Color(0xff707070),
                    // height: 220,
                    // width: Get.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: GetBuilder<SettignsController>(
                                // init: SettignsController(),
                                builder: (value) {
                                  return settingsController.isProNetwork ==
                                          false
                                      ? Image.file(
                                          settingsController.profile!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : settingsController.isProNetwork == true
                                          ? Image.network(
                                              settingsController.profileString!,
                                              height: 100,
                                              width: 100,
                                            )
                                          : CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.account_circle,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                            );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            child: GestureDetector(
                              onTap: () {
                                settingsController.isChecking = true;
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.textColorGreen,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 230,
                  left: Get.width / 2 - 70,
                  child: GestureDetector(
                    onTap: () {
                      settingsController.isChecking = false;
                      _showPicker(context);
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.textColorGreen,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffD2D2D2),
                              offset: Offset(-1, -1),
                              blurRadius: 2,
                              spreadRadius: 0.8)
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '+ Change Banner',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Your Details',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 2,
            ),
            Container(
              height: 150,
              width: Get.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'First name',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  TextFormField(
                    controller: fname,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Last name',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  TextFormField(
                      controller: lName,
                      // initialValue:fname==null? "emon":"vendor",
                      maxLines: 1,
                      validator: (value) {
                        // if (value.trim().isEmpty)
                        //   return "Email is Required";
                        // else if (!GetUtils.isEmail(value.trim()))
                        //   return "Please enter valid email";
                        // else
                        //   return null;
                      })
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Your Location',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 2,
            ),
            Container(
              height: 495,
              width: Get.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Country',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  TextFormField(
                    controller: country,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Your Address',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  TextFormField(
                    controller: address,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Enter Longitute(optional)',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  TextFormField(
                    controller: longitute,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Enter Langitute(optional)',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  TextFormField(
                    controller: latituate,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Company Details',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 73,
              width: Get.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'No of Employess you have',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  //SizedBox(height: 5,),
                  TextFormField(
                    controller: noOfEmployees,
                    // initialValue:fname==null? "emon":"vendor",
                    maxLines: 1,
                    validator: (value) {
                      // if (value.trim().isEmpty)
                      //   return "Email is Required";
                      // else if (!GetUtils.isEmail(value.trim()))
                      //   return "Please enter valid email";
                      // else
                      //   return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},

              child: Text(
                'SAVE SETTINGS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimension.text_size_semi_medium,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
