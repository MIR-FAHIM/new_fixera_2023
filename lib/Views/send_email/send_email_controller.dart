import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO_NETWORK;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../Utilities/AppUrl.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';

class SendEmailController extends GetxController {
  var emailForm = GlobalKey<FormState>().obs;
  //GlobalKey<HtmlEditorState> keyBodyEditor = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  RxBool buttonStatus = false.obs;
  RxString description = "".obs;
  List<PlatformFile>? filePaths;

  RxString extension = "".obs;
  bool multiPick = true;
  FileType pickingType = FileType.any;
  RxBool hasFile = false.obs;
  RxBool btnLoader = false.obs;

  void updateButtonStatus() {
    try {
      if (emailForm.value.currentState!.validate()) {
        buttonStatus.value = true;
      } else {
        buttonStatus.value = false;
      }
    } catch (e) {}
  }

  PlatformFile? pickedFile= null;
  List<PlatformFile>? imageFiles = [];

  RxInt fileCount = 0.obs;

  void chooseFileUsingFilePicker() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );

    if (result != null) {
      log("HERE::: ${result.files.length}");
      fileCount.value = result.files.length;
      for (int i = 0; i < fileCount.value; i++) {
        imageFiles = result.files;
        pickedFile = result.files[i];
        //pickedFile = result.files[i];

      }
      log("HERE IS:: ${imageFiles}");
      hasFile.value = true;
    } else {
      hasFile.value = false;
    }
  }

  // sendEmail() async {
  //   btnLoader.value = true;
  //   description.value = await keyBodyEditor.currentState.getText();
  //   if (description.value.toString().isEmpty) {
  //     Fluttertoast.showToast(
  //         msg: "Description is required",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 12.0);
  //     btnLoader.value = false;
  //     return;
  //   }
  //
  //   try {
  //     var tokenVal = SharedPref.to.prefss.getString("token");
  //     final request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse("${AppUrl.SEND_EMAIL}"),
  //     );
  //     request.headers['Authorization'] = 'Bearer $tokenVal';
  //     request.fields["receiver_email"] = "${emailController.text.trim()}";
  //     request.fields["subject"] = "${subjectController.text.trim()}";
  //     request.fields["description"] = "${description.value}";
  //
  //     if (pickedFile != null) {
  //       // request.files.add(new http.MultipartFile(
  //       //     "attachments", pickedFile.readStream, pickedFile.size,
  //       //     filename: pickedFile.name));
  //
  //       for (int i = 0; i < imageFiles.length; i++) {
  //         request.files.add(http.MultipartFile(
  //             'attachments', imageFiles[i].readStream, imageFiles[i].size,
  //             filename: imageFiles[i].name));
  //       }
  //     }
  //
  //     //-------Send request
  //     log("HERE FIELDS ARE:: ${request.files}");
  //     var resp = await request.send();
  //
  //     //------Read response
  //     String result = await resp.stream.bytesToString();
  //     //-------Your response
  //     print("THE RESP:: ${jsonDecode(result)}");
  //     ///////////////
  //
  //     if (jsonDecode(result)['error'] == false) {
  //       Get.back();
  //       Fluttertoast.showToast(
  //           msg: "${jsonDecode(result)['results']['message']}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 12.0);
  //       btnLoader.value = false;
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "${jsonDecode(result)['results']['message']}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 12.0);
  //     }
  //   } catch (e) {
  //     btnLoader.value = false;
  //     throw e;
  //   }
  // }



  uploadImage() async {
    // create multipart request
    btnLoader.value = true;
   // description.value = await keyBodyEditor!.currentState!.getText();
    try{
      if (description.value.toString().isEmpty) {
        Fluttertoast.showToast(
            msg: "Description is required",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        btnLoader.value = false;
        return;
      }
      var tokenVal = SharedPref.to.prefss!.getString("token");
      var request = http.MultipartRequest('POST', Uri.parse("${AppUrl.SEND_EMAIL}"));

      request.headers['Authorization'] = 'Bearer $tokenVal';
      request.fields["receiver_email"] = "${emailController.text.trim()}";
      request.fields["subject"] = "${subjectController.text.trim()}";
      request.fields["description"] = "${description.value}";

      if (imageFiles!.length > 0) {
        for (var i = 0; i < imageFiles!.length; i++) {
          //request.files.add(http.MultipartFile('attachments',
          request.files.add(http.MultipartFile('attachments[]',
              File(imageFiles![i].path!).readAsBytes().asStream(),
              File(imageFiles![i].path!).lengthSync(),
              filename: imageFiles![i].path!
                  .split("/")
                  .last));
        }
      }

      // send
      var response = await request.send();



      // listen for response
      log("FILES ARE: ${request.files}");
      response.stream.transform(utf8.decoder).listen((value) {
        if(jsonDecode(value)['error']==false){
          Get.back();
          Fluttertoast.showToast(
              msg: "${jsonDecode(value)['results']['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12.0);
          btnLoader.value = false;
        }else{
          Fluttertoast.showToast(
              msg: "${jsonDecode(value)['results']['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12.0);
        }

        // debugPrint(value);
      });

    }catch(e){
      btnLoader.value = false;
    }

  }
}
