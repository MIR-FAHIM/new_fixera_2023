import 'package:new_fixera/Controller/SignUpController.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class StartNowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartNowPageState();
  }
}

class StartNowPageState extends State<StartNowPage> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerFirstName =
      new TextEditingController();
  static TextEditingController controllerLastName = new TextEditingController();
  static TextEditingController controllerEmail = new TextEditingController();
  static TextEditingController controllerPhone = new TextEditingController();
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            // color: AppColors.backgroundColor,
            child: Image.asset(
              'images/fixera_logo.png',
              height: 40,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.center,
            // color: AppColors.backgroundColor,
            child: Text(
              "Join For a Good Start",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimension.text_size_medium,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            // color: AppColors.backgroundColor,
            child: Text(
              "Join for a good reason & benefit Yourself!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimension.text_size_small,
                color: AppColors.textColorGrey,
              ),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Form(
                    key: formKey,
                    // ignore: deprecated_member_use
                    //  autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          autovalidateMode: AutovalidateMode.disabled,
                          maxLines: 1,
                          controller: controllerFirstName,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          validator: (value1) {
                            if (value1!.isEmpty || value1 == null) {
                              return "First Name is Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value2) {
                              if (value2!.isEmpty || value2 == null) {
                                return "Last Name is Required";
                              } else {
                                return null;
                              }
                            },
                            controller: controllerLastName),
                        SizedBox(height: 20),
                        TextFormField(
                            maxLines: 1,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value3) {
                              if (value3!.isEmpty && value3 == null)
                                return "Email is Required";
                              else if (!GetUtils.isEmail(value3))
                                return "Please enter valid email";
                              else
                                return null;
                            },
                            controller: controllerEmail),
                        SizedBox(
                          height: 25,
                        ),
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          controller: controllerPhone,
                          initialCountryCode: 'US',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          validator: (value) {
                            if (value.isEmpty && value == null)
                              return "Phone Number is Required";
                            else if (!GetUtils.isPhoneNumber(value))
                              return "Please enter valid phone number";
                            else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
