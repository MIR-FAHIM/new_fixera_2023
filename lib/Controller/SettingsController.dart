import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:new_fixera/Controller/ExportController.dart';
import 'package:new_fixera/Views/Utilities/AppRoutes.dart';
import 'package:new_fixera/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettignsController extends GetxController {
  FilePicker? imageProfile, imageBanner;
  Image? bannerImage, profileImage;
  ImagePicker _picker = ImagePicker();
  File? profile, banner;
  bool? isChecking;
  List<String> image = [];
  bool? isBnNetwork, isProNetwork = false;
  String? bannerString, profileString;

  @override
  onInit() {
    // super.onInit();
    print("called OnInt");

    if (userMap == null) {
      prefs!.clear();
      Get.offAllNamed(AppRoutes.SIGNINPAGE);
    }
    var b = userMap!["user_info"]["banner"];
    var p = userMap!["user_info"]["avatar"];
    if (b != null) {
      isBnNetwork = true;
      bannerString = b;
    } else {
      isBnNetwork = false;
      callFiles().then((value) {
        if (value[0] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/banner.png") {
          banner = File(value[0]);
          profile = File(value[1]);
        } else if (value[1] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/banner.png") {
          banner = File(value[1]);
          profile = File(value[0]);
        } else if (value[0] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/profile.png") {
          profile = File(value[0]);
          banner = File(value[1]);
        } else if (value[1] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/profile.png") {
          profile = File(value[1]);
          banner = File(value[0]);
        }
        print("Profile");
        print(profile);
        print(banner);
      });
    }

    if (p != null) {
      isProNetwork = true;
      profileString = p;
    } else {
      isProNetwork = false;
      callFiles().then((value) {
        if (value[0] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/banner.png") {
          banner = File(value[0]);
          profile = File(value[1]);
        } else if (value[1] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/banner.png") {
          banner = File(value[1]);
          profile = File(value[0]);
        } else if (value[0] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/profile.png") {
          profile = File(value[0]);
          banner = File(value[1]);
        } else if (value[1] ==
            "/storage/emulated/0/Android/data/com.fixera.app/files/new_fixera/profile.png") {
          profile = File(value[1]);
          banner = File(value[0]);
        }
        print("Profile");
        print(profile);
        print(banner);
      });
    }
    update();
  }

  // imgFromCamera() async {
  //   if (isChecking == true) {
  //     isProNetwork = false;
  //     ImagePicker pickedFile = await ImagePicker().pickImage(
  //       source: source,
  //       maxWidth: maxWidth,
  //       maxHeight: maxHeight,
  //       imageQuality: quality,
  //     );
  //     try {
  //       if (imageProfile != null) {
  //         File newImageDir = await File(imageProfile!.path)
  //             .copy("$visionBoardDirectoryPath/profile.png");
  //         profileImage = Image.file(newImageDir);
  //         print(newImageDir.path);
  //       }
  //
  //       profile = File(imageProfile!.path);
  //     } catch (e) {
  //       return null;
  //     }
  //   } else {
  //     imageBanner =
  //         await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
  //     try {
  //       isBnNetwork = false;
  //       if (imageBanner != null) {
  //         File newImageDir = await File(imageBanner!.path)
  //             .copy("$visionBoardDirectoryPath/banner.png");
  //         bannerImage = Image.file(newImageDir);
  //         print(newImageDir.path);
  //       }
  //       print('banner ${imageBanner!.path}');
  //       banner = File(imageBanner!.path);
  //     } catch (e) {
  //       return null;
  //     }
  //   }
  //   update();
  // }

  // imgFromGallery() async {
  //   if (isChecking == true) {
  //     isProNetwork = false;
  //     imageProfile =
  //         await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
  //     try {
  //       if (imageProfile != null) {
  //         File newImageDir = await File(imageProfile!.path)
  //             .copy("$visionBoardDirectoryPath/profile.png");
  //         profileImage = Image.file(newImageDir);
  //         print(newImageDir.path);
  //       }
  //       profile = File(imageProfile!.path);
  //     } catch (e) {
  //       return null;
  //     }
  //   } else {
  //     isBnNetwork = false;
  //     imageBanner =
  //         await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
  //     try {
  //       if (imageBanner != null) {
  //         File newImageDir = await File(imageBanner!.path)
  //             .copy("$visionBoardDirectoryPath/banner.png");
  //         profileImage = Image.file(newImageDir);
  //         print(newImageDir.path);
  //       }
  //       banner = File(imageBanner!.path);
  //     } catch (e) {
  //       return null;
  //     }
  //   }
  //
  //   update();
  // }

  Future<List<String>> callFiles() async {
    final _visionBoardImageDir = Directory(visionBoardDirectoryPath);

    final files = await _visionBoardImageDir.list().toList();
    files.forEach((element) {
      image.add(element.path);
    });
    print(image);
    return image;
  }
}
