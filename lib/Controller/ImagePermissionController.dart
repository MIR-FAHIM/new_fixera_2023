import 'package:new_fixera/Repositories/repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider_ex/path_provider_ex.dart';

//Globally Declare for the ImageSave and Retrive and permissionHandler
List<StorageInfo> _storageInfo = [];
var visionBoardDirectoryPath = '';
var _internalDirectory;

class ImagepermissionController extends GetxController {
  final MyRepository? repository;
  ImagepermissionController({@required this.repository})
      : assert(repository != null);

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    initPlatformState();
    _permissionHandler();
    createDir();
  }

  ///This part is for ImageSave and ImageRetirve Permission
  createDir() async {
    // Directory baseDir = await getExternalStorageDirectory(); //only for Android
    // Directory baseDir =
    //     await getApplicationDocumentsDirectory(); //works for both iOS and Android

    String dirToBeCreated = "Fixera";
    String finalDir = join(_internalDirectory, dirToBeCreated);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create();
      // _callFiles();
      print("$finalDir is not EXIST. Now created!");
    }

    print("$finalDir is EXIST");
    visionBoardDirectoryPath = finalDir;
    // print(visionBoardDirectoryPath);
    // _callFiles();
  }

// get storage path
  initPlatformState() async {
    List<StorageInfo>? storageInfo;
    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    // if (!mounted) return;
    _storageInfo = storageInfo!;
    _internalDirectory = _storageInfo[0].appFilesDir;

    print("the appFilesDir: $_internalDirectory");
  }

// permission handler
  Future<void> _permissionHandler() async {
    var storageStatus = await Permission.storage.status;
    var cameraStatus = await Permission.camera.status;
    print("$storageStatus + $cameraStatus");

    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    if (await Permission.storage.isGranted) {
      if (await Permission.camera.isGranted) {
        createDir();
        print("$storageStatus + $cameraStatus");
      } else {
        print("camera not permitted!");
      }
    } else {
      print("Storage not permitted!");
    }
  }
}
