import 'package:new_fixera/Model/ExportModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart';

class ForgotMail extends StatefulWidget {
  ForgotMail({Key? key}) : super(key: key);

  @override
  _ForgotMailState createState() => _ForgotMailState();
}

class _ForgotMailState extends State<ForgotMail> {
  TextEditingController _emailFilter = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  ForgotEmail? _forgotEmail;
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));


  void displayMessage()
  {
    print("***********************");
    print("DISPLAY MESSAGE");
    print("***********************");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: Text(
              "Please Try Again++++++++",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              GestureDetector(
                child: Text("Ok"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
          return dialog;
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recover Password"),
      ),
      body: Container(
      child: SingleChildScrollView(
        child: Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
        SizedBox(
          height: 80.0,
        ),
        Container(
          alignment: Alignment.center,
          // color: AppColors.backgroundColor,
          child: Image.asset(
            'images/fixera_logo.png',
            height: 60,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 1,
              controller: _emailFilter,
              decoration: new InputDecoration(
                labelText: 'Email',
                suffixIcon: Icon(
                  Icons.email_outlined,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty)
                  return "Email is Required";
                else if (!GetUtils.isEmail(value.trim()))
                  return "Please enter valid email";
                else
                  return null;
              },
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        GestureDetector(
          onTap: () => moveToForgotOtp(),

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'SUBMIT',
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: Dimension.text_size_large,
              ),
            ),
          ),

        ),
    ],
      ),
      )),
    );
  }


  moveToForgotOtp() async {
    try {
      print(_emailFilter.text);
      if (formKey.currentState!.validate()) {
        ForgotEmail forgotEmail =await myRepository.forgotEmail(_emailFilter.text);
        setState(() {
          _forgotEmail = forgotEmail;
        });
        if (_forgotEmail!.error == false) {
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: const Text('Enter Verification Code'),
              action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
            ),
          );

          Get.offAndToNamed(AppRoutes.FORGOTOTP,arguments: _forgotEmail!.results!.userId);
        } else {
          final scaffold = ScaffoldMessenger.of(context);
          scaffold.showSnackBar(
            SnackBar(
              content: Text('Something Went Wrong'),
              action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
            ),
          );
          print("+++++++++++++++");
          // displayMessage();
           print(_forgotEmail!.error);
        }
      }
    } catch (e) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Something Went Wrong'),
          action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
      print("Catch Error");
      print(e);
    }
  }
}
