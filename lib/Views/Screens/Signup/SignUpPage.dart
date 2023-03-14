import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:new_fixera/Model/SignUpModel/ProfessionalInfoModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/ExportScreens.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? checkedValue = true;
  bool? loader = false;
  bool? existEmail;
  bool? isSignUpPost;
  var currentStep = 0;
  int visible = 0;
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  ProfessionalInfoModel? _professionalInfoModel;
  var _userId;

  var _url = "https://fix-era.com/page/terms-conditions";

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void displayMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: Text(
              "Please Select Terms And Conditions",
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

  getCurrentScreen() {
    print("+++++++++++++++++++++++++");
    print(currentStep);
    print("+++++++++++++++++++++++++");
  }

  @override
  Widget build(BuildContext context) {
    var signUpData = HashMap<String, String>();
    signUpData["first_name"] = StartNowPageState.controllerFirstName.text;
    signUpData["last_name"] = StartNowPageState.controllerLastName.text;
    signUpData["email"] = StartNowPageState.controllerEmail.text;
    signUpData["password"] = ProfessionalInfoPageState.controllerPassword.text;
    signUpData["confirm_password"] =
        ProfessionalInfoPageState.controllerConfirmPassword.text;
    signUpData["verification_code"] =
        VerificationPageState.controllerVerificationCode.text;
    signUpData["Type"] = ProfessionalInfoPageState.grpVal.toString();

    void clearEditingController() {
      StartNowPageState.controllerFirstName.clear();
      StartNowPageState.controllerLastName.clear();
      StartNowPageState.controllerEmail.clear();
      ProfessionalInfoPageState.controllerPassword.clear();
      ProfessionalInfoPageState.controllerConfirmPassword.clear();
      VerificationPageState.controllerVerificationCode.clear();
      // ProfessionalInfoPageState.initialSignature.clear();
      ProfessionalInfoPageState.userSignatureController.clear();
    }

    List<Step> steps = [
      Step(
        title: Text(''),
        content: StartNowPage(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: ProfessionalInfoPage(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: VerificationPage(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(''),
        content: CongratulationsPage(),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    startNow() async {
      print("pressed");
      if (StartNowPageState.formKey.currentState!.validate() &&
          currentStep == 0) {
        setState(() {
          visible++;
        });
        existEmail = await myRepository
            .postEmailExist(StartNowPageState.controllerEmail!.text);
      }
      if (currentStep < steps.length - 1) {
        if (currentStep == 0 &&
            StartNowPageState.formKey.currentState!.validate()) {
          if (existEmail == false) {
            setState(() {
              visible = 0;
              currentStep = currentStep + 1;
            });
          } else {
            setState(() {
              visible = 0;
            });
            Get.snackbar("Email Exist", "This Email has already been taken",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        }
      } else {
        setState(() {
          currentStep = 0;
        });
      }
    }

    nextPage() async {
      // Uint8List signatureString = utf8
      //     .encode(ProfessionalInfoPageState.userSignatureController.toString());
      var dir = await getTemporaryDirectory();
      File userSugnatureFile = File(dir.path + '/userSign.png');
      await userSugnatureFile.writeAsBytes(
          await ProfessionalInfoPageState.userSignatureController.toPngBytes());
      final bytes = File(userSugnatureFile.path).readAsBytesSync();
      String signatureString = "data:image/png;base64," + base64Encode(bytes);

      log("BASE 64 IMG:: $signatureString");

      ProfessionalInfoPageState.errorGroupValue = "";
      ProfessionalInfoPageState.errorLocation = "";
      var role =
          ProfessionalInfoPageState.grpVal == 0 ? "vendor" : "contractor";

      if (ProfessionalInfoPageState.formKey.currentState!.validate() &&
              ProfessionalInfoPageState.grpVal == 0 &&
              ProfessionalInfoPageState.selectedLocation != null &&
              ProfessionalInfoPageState.mySelectionEmployee != null
          //&&
          //ProfessionalInfoPageState.mySelectionDepartment != null
          ) {
        setState(() {
          visible++;
        });

        ProfessionalInfoModel professionalInfoModel =
            await myRepository.postSignInData(
                StartNowPageState.controllerFirstName.text,
                StartNowPageState.controllerLastName.text,
                StartNowPageState.controllerEmail.text,
                StartNowPageState.controllerPhone.text,
                ProfessionalInfoPageState.selectedLocation,
                role,
                ProfessionalInfoPageState.mySelectionEmployee,
                ProfessionalInfoPageState.mySelectionDepartment,
                ProfessionalInfoPageState.selectedCategories,
                ProfessionalInfoPageState.controllerPassword.text,
                //ProfessionalInfoPageState.initialSignature.text);
                signatureString.toString());

        setState(() {
          _professionalInfoModel = professionalInfoModel;
        });

        if (_professionalInfoModel!.error == false) {
          setState(() {
            visible = 0;
            _userId = _professionalInfoModel!.results!.userId;
            currentStep = currentStep + 1;
            ProfessionalInfoPageState.errorGroupValue = "";
            ProfessionalInfoPageState.errorLocation = " ";
            //clearEditingController();
          });
        } else {
          Get.snackbar("Wrong Message", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else if (ProfessionalInfoPageState.formKey.currentState!.validate() &&
          ProfessionalInfoPageState.grpVal == 1 &&
          ProfessionalInfoPageState.selectedLocation != null &&
          ProfessionalInfoPageState.selectedCategories != null) {
        setState(() {
          visible++;
        });

        ProfessionalInfoModel professionalInfoModel =
            await myRepository.postSignInData(
          StartNowPageState.controllerFirstName.text,
          StartNowPageState.controllerLastName.text,
          StartNowPageState.controllerEmail.text,
          StartNowPageState.controllerPhone.text,
          ProfessionalInfoPageState.selectedLocation,
          role,
          ProfessionalInfoPageState.mySelectionEmployee,
          ProfessionalInfoPageState.mySelectionDepartment,
          ProfessionalInfoPageState.selectedCategories,
          ProfessionalInfoPageState.controllerPassword.text,
          //ProfessionalInfoPageState.initialSignature.text,
          signatureString.toString(),
        );

        setState(() {
          _professionalInfoModel = professionalInfoModel;
        });
        if (_professionalInfoModel!.error == false) {
          setState(() {
            visible = 0;

            _userId = _professionalInfoModel!.results!.userId;
            currentStep = currentStep + 1;
            ProfessionalInfoPageState.errorGroupValue = "";
            ProfessionalInfoPageState.errorLocation = " ";
            //clearEditingController();
          });
        } else {
          Get.snackbar("Wrong Message", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        if (ProfessionalInfoPageState.grpVal == null) {
          setState(() {
            ProfessionalInfoPageState.errorGroupValue =
                "Please Select Your Type";
          });
        } else if (ProfessionalInfoPageState.selectedLocation == null) {
          setState(() {
            ProfessionalInfoPageState.errorLocation =
                "Please Select Your Location";
          });
        } else if (ProfessionalInfoPageState.mySelectionEmployee == null &&
            ProfessionalInfoPageState.grpVal == 0) {
          setState(() {
            ProfessionalInfoPageState.errorGroupValue =
                "Please Select Your No of Employees";
          });
        }
        // else if (ProfessionalInfoPageState.mySelectionDepartment == null &&
        //     ProfessionalInfoPageState.grpVal == 0) {
        //   setState(() {
        //     ProfessionalInfoPageState.errorGroupValue =
        //         "Please Select Your Departments";
        //   });
        // }
        else if (ProfessionalInfoPageState.selectedCategories == null &&
            ProfessionalInfoPageState.grpVal == 1) {
          setState(() {
            ProfessionalInfoPageState.errorGroupValue =
                "Please Select Your Categories";
          });
        }
      }
    }

    verificationPage() async {
      bool vrifyOtp = false;
      if (VerificationPageState.formKey.currentState!.validate()) {
        print("verify func" + _userId.toString());
        setState(() {
          visible++;
        });
        // vrifyOtp = await myRepository.verification(
        //     VerificationPageState.controllerVerificationCode.text,
        //     _userId,
        //     "register",
        //     StartNowPageState.controllerEmail.text,
        //     StartNowPageState.controllerPhone.text,
        //     ProfessionalInfoPageState.controllerPassword.text);
        vrifyOtp = await myRepository.verification(
            forgotVerification:
                VerificationPageState.controllerVerificationCode.text,
            // _userId,
            // "register",
            // StartNowPageState.controllerEmail.text,
            // StartNowPageState.controllerPhone.text,
            // ProfessionalInfoPageState.controllerPassword.text,
            userId: _userId,
            type: "register",
            email: StartNowPageState.controllerEmail.text,
            phone: StartNowPageState.controllerPhone.text,
            password: ProfessionalInfoPageState.controllerPassword.text);
      }

      if (currentStep == 2 &&
          VerificationPageState.formKey.currentState!.validate() &&
          vrifyOtp == false) {
        setState(() {
          visible = 0;
          currentStep = currentStep + 1;
          loginStatus = true;

          SharedPref.to.prefss!.getString("token");
          SharedPref.to.prefss!.getString("token_type");
          prefs!.setBool("loginStatus", loginStatus);

          clearEditingController();
          print(signUpData);
        });
      } else {
        setState(() {
          visible = 0;
          loginStatus = false;
          prefs!.setBool("loginStatus", loginStatus);
        });
        print("error is true");
      }
    }

    return Scaffold(
      appBar:AppBar(
        title: Text("Sign Up"),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.backgroundColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Get.offAndToNamed(AppRoutes.SIGNINPAGE);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height / 1.197,
              child: Stepper(
                currentStep: this.currentStep,
                steps: steps,
                type: StepperType.horizontal,
                // onStepTapped: (step) {
                //   setState(() {
                //     currentStep = step;
                //   });
                // },
                onStepContinue: () => currentStep == 0
                    ? startNow()
                    : currentStep == 1
                        ? nextPage()
                        : verificationPage(),
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                controlsBuilder:
                    //(BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                    (BuildContext context, ControlsDetails controls) {
                  return Column(
                    children: [
                      (currentStep == 1)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: checkedValue,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        checkedValue = newValue;
                                        print(checkedValue.toString() +
                                            "**********CHECKBOX**********");
                                      });
                                    },
                                  ),
                                  Text(
                                    "Agree to Fixera Agreements,",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _launchURL();
                                    },
                                    child: Text(
                                      " Terms And Conditions",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 8),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (currentStep == 0 || currentStep > 2)
                              ? Container()
                              : GestureDetector(
                                  onTap: controls.onStepCancel,

                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "PREVIOUS",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                ),
                          SizedBox(
                            width: 20.0,
                          ),
                          currentStep > 2
                              ? Container()
                              : GestureDetector(
                                  onTap: currentStep == 1
                                      ? checkedValue == false
                                          ? displayMessage
                                          : controls.onStepContinue
                                      : controls.onStepContinue,

                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "CONTINUE",
                                      style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                ),
                          // GestureDetector(
                          //   onPressed: onStepContinue,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10),
                          //     child: Text(
                          //       currentStep == 0 ? "START NOW" : "CONTINUE",
                          //       style: TextStyle(
                          //         color: AppColors.backgroundColor,
                          //         fontSize: Dimension.text_size_large,
                          //       ),
                          //     ),
                          //   ),
                          //   color: Colors.green,
                          // ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
