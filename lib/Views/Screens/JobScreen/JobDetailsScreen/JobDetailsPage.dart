import 'dart:io';
import 'package:new_fixera/Controller/JobController.dart';
import 'package:new_fixera/Model/JobModel/JobPrivatePubLicModel.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Repositories/repository.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/WebAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class JobDetailsPage extends StatefulWidget {
  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final MyRepository myRepository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  JobPrivatePublicModel? _jobPrivatePublicModel;
  final JobController jobController = Get.put(JobController());
  String? _jobUrl;
  String? check;
  double progress = 0;


  InAppWebViewController? _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    check = Get.arguments[0];
    if (check == "AlreadyPaid") {
      _jobUrl = Get.arguments[1];
      print("Check JobUrl" + _jobUrl!);
    } else {
      String slug = Get.arguments[1];
      var jobId = Get.arguments[2];
      String status = Get.arguments[3];
      fetchPublicPrivateUrl(slug, jobId, status);
    }
  }

  void fetchPublicPrivateUrl(String slug, var jobId, String status) async {
    print(slug);
    print(jobId);
    print(status);
    JobPrivatePublicModel jobPrivatePublicModel =
        await myRepository.postPublicPrivateJob(slug, jobId, status);
    print("Check funtion");
    setState(() {
      _jobPrivatePublicModel = jobPrivatePublicModel;
      // print(_jobPrivatePublicModel.results.jobUrl);
    });
  }

  Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController!.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }

  static void callback(String id, DownloadTaskStatus status, int progress) {}

  void goBack()
  {
    Get.back();
    Fluttertoast.showToast(
        msg: "Please Update Package",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

  @override
  Widget build(BuildContext context) {
    print("*****************");
    print("job Url");
    print(_jobUrl);
    // print(newJobUrl);
    // print(newJobUrl+SharedPref.to.prefss.getString("token"));
    //print(_jobPrivatePublicModel.results.jobUrl);
    print("*****************");
    return WillPopScope(
      onWillPop: () {
        Get.back();
        var a ;
        return a;
        // if (_webViewController != null) {
        //   print("print Pressed");
        //   _webViewController.canGoBack().then((value) {
        //     if (value) {
        //       _webViewController.goBack();
        //     } else {
        //       Get.back();
        //     }
        //   });
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Job Details"),
        ),
        //webAppbar("Job Details", _webViewController),
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          onPressed: () async {
            await _onRefresh();
          },
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 30,
            child: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
              check == "AlreadyPaid"
                  ? Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: InAppWebView(
                          initialHeaders: MyApiClient.header2(),
                          //initialUrl: _jobUrl,
                          initialUrl: _jobUrl! +
                              "?token=" +
                              SharedPref.to.prefss!.getString("token")!,
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                                debuggingEnabled: true,
                                useOnDownloadStart: true,
                                useOnLoadResource: true,
                                javaScriptEnabled: true,
                                useShouldInterceptAjaxRequest: true,
                                javaScriptCanOpenWindowsAutomatically: true,
                                useShouldOverrideUrlLoading: true),
                            android: AndroidInAppWebViewOptions(
                                allowContentAccess: true,
                                hardwareAcceleration: true,
                                databaseEnabled: true,
                                allowFileAccess: true,
                                thirdPartyCookiesEnabled: true,
                                allowFileAccessFromFileURLs: true,
                                allowUniversalAccessFromFileURLs: true,
                                useShouldInterceptRequest: true,
                                domStorageEnabled: true,
                                supportMultipleWindows: true),
                          ),
                          onDownloadStart: (controller, url) async {
                            FlutterDownloader.registerCallback(callback);

                            // print("onDownloadStart $url");
                            print("first step");
                            print("first step");
                            print("first step");
                            print("first step");
                            print("first step");
                            print("first step");
                            print("first step");
                            Directory directory = Platform.isAndroid
                                ?
                                // Directory(
                                //         "/storage/emulated/0/Android/data/com.fixera.app/files/Fixera")

                                Directory("/storage/emulated/0/Download/Fixera")
                                : await getApplicationDocumentsDirectory();
                            print("second step");
                            print(directory.uri.path);
                            print(directory.uri.path);
                            print(directory.uri.path);
                            print(directory.path);
                            print(directory.path);
                            print(directory.path);
                            print(directory.path);
                            print(directory.path);
                            await directory.create(recursive: true);
                            Get.snackbar("Downloading",
                                "File is Saving in your File manager",
                                colorText: Colors.white,
                                backgroundColor: Colors.green);

                            //Download Option

                            await FlutterDownloader.enqueue(
                              url: url +
                                  "?token=" +
                                  SharedPref.to.prefss!.getString("token")!,
                              savedDir: directory.uri.path,
                              requiresStorageNotLow: true,
                              showNotification: false,
                              // show download progress in status bar (for Android)
                              openFileFromNotification:
                                  false, // click on notification to open downloaded file (for Android)
                            );

                            //Download Option
                          },
                          onLoadStart:
                              (InAppWebViewController controller, String url) {
                            // setState(() {
                            //   this._jobUrl=url;
                            // });

                            _webViewController!.clearCache();
                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                  .javaScriptCanOpenWindowsAutomatically = true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            print("onLoadStart" + url);
                          },
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action: PermissionRequestResponseAction.GRANT);
                          },
                          onLoadStop: (InAppWebViewController controller,
                              String url) async {
                            print("onLoadStop" + url);
                            // if (url.substring(0, 43) ==
                            //     "https://www.fix-era.com/api/v1/webview/job") {
                            //   print("Working");
                            //   Get.toNamed(AppRoutes.SENDPROPOSAL);
                            // }
                            _webViewController!
                                .getUrl()
                                .then((value) => print(value));
                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                  .javaScriptCanOpenWindowsAutomatically = true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            _webViewController!.clearCache();
                          },
                          onProgressChanged: (InAppWebViewController controller,
                              int progress) {
                            setState(() {
                              this.progress = progress / 100;
                            });
                          },
                          shouldOverrideUrlLoading: (controller,
                              shouldOverrideUrlLoadingRequest) async {
                            print(
                                "URL: ${shouldOverrideUrlLoadingRequest.url}");
                            _webViewController!.clearCache();

                            if (Platform.isAndroid ||
                                shouldOverrideUrlLoadingRequest
                                        .iosWKNavigationType ==
                                    IOSWKNavigationType.LINK_ACTIVATED) {
                              controller.loadUrl(
                                  // url: shouldOverrideUrlLoadingRequest.url+"?token="+SharedPref.to.prefss.getString("token"),
                                  url: shouldOverrideUrlLoadingRequest.url,
                                  headers: MyApiClient.header2());
                              return ShouldOverrideUrlLoadingAction.CANCEL;
                            }
                            return ShouldOverrideUrlLoadingAction.ALLOW;
                          },
                          onConsoleMessage: (InAppWebViewController controller,
                              ConsoleMessage consoleMessage) {
                            print("console message: ${consoleMessage.message}");
                          },
                        ),
                      ),
                    )
                  : _jobPrivatePublicModel != null
                      ? Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: InAppWebView(
                                  initialHeaders: MyApiClient.header2(),
                                  initialUrl: _jobPrivatePublicModel!
                                          .results!.jobUrl! +
                                      "?token=" +
                                      SharedPref.to.prefss!.getString("token")!,
                                  onLoadStart: (InAppWebViewController controller,
                                      String url) {
                                    _webViewController!.clearCache();
                                    _webViewController!.getOptions().then(
                                      (value) {
                                        value.crossPlatform
                                                .useShouldInterceptAjaxRequest =
                                            true;
                                        value.crossPlatform
                                                .javaScriptCanOpenWindowsAutomatically =
                                            true;
                                        value.crossPlatform.debuggingEnabled =
                                            true;
                                      },
                                    );
                                    print("onLoadStart" + url);
                                  },
                                  initialOptions: InAppWebViewGroupOptions(
                                    crossPlatform: InAppWebViewOptions(
                                        debuggingEnabled: true,
                                        useOnDownloadStart: true,
                                        useOnLoadResource: true,
                                        javaScriptEnabled: true,
                                        useShouldInterceptAjaxRequest: true,
                                        javaScriptCanOpenWindowsAutomatically:
                                            true,
                                        useShouldOverrideUrlLoading: true),
                                    android: AndroidInAppWebViewOptions(
                                        allowContentAccess: true,
                                        hardwareAcceleration: true,
                                        databaseEnabled: true,
                                        allowFileAccess: true,
                                        thirdPartyCookiesEnabled: true,
                                        allowFileAccessFromFileURLs: true,
                                        allowUniversalAccessFromFileURLs: true,
                                        useShouldInterceptRequest: true,
                                        domStorageEnabled: true,
                                        supportMultipleWindows: true),
                                  ),
                                  onDownloadStart: (controller, url) async {
                                    // print("onDownloadStart $url");
                                    print("sdjhfalksjdhfla");

                                    await FlutterDownloader.enqueue(
                                      headers: MyApiClient.header2(),
                                      url: url +
                                          "?token=" +
                                          SharedPref.to.prefss!
                                              .getString("token")!,
                                      savedDir:
                                          "/storage/emulated/0/Android/data/com.fixera.app/files/Fixera",
                                      requiresStorageNotLow: true,
                                      showNotification: true,
                                      // show download progress in status bar (for Android)
                                      openFileFromNotification:
                                          false, // click on notification to open downloaded file (for Android)
                                    ).then(
                                      (value) {
                                        print("What is this " + value!);
                                        Get.snackbar("Download",
                                            "File is Saved in your File manager",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.green);
                                      },
                                    );
                                  },
                                  shouldOverrideUrlLoading: (controller,
                                      shouldOverrideUrlLoadingRequest) async {
                                    print(
                                        "URL: ${shouldOverrideUrlLoadingRequest.url}");
                                    _webViewController!.clearCache();

                                    if (Platform.isAndroid ||
                                        shouldOverrideUrlLoadingRequest
                                                .iosWKNavigationType ==
                                            IOSWKNavigationType
                                                .LINK_ACTIVATED) {
                                      controller.loadUrl(
                                          url: shouldOverrideUrlLoadingRequest
                                                  .url +
                                              "?token=" +
                                              SharedPref.to.prefss!
                                                  .getString("token")!,
                                          headers: MyApiClient.header2());
                                      return ShouldOverrideUrlLoadingAction
                                          .CANCEL;
                                    }
                                    return ShouldOverrideUrlLoadingAction.ALLOW;
                                  },
                                  onWebViewCreated:
                                      (InAppWebViewController controller) {
                                    _webViewController = controller;
                                  },
                                  androidOnPermissionRequest:
                                      (controller, origin, resources) async {
                                    return PermissionRequestResponse(
                                        resources: resources,
                                        action: PermissionRequestResponseAction
                                            .GRANT);
                                  },
                                  onLoadStop: (InAppWebViewController controller,
                                      String url) async {
                                    print("onLoadStop" + url);
                                    _webViewController!
                                        .getUrl()
                                        .then((value) => print(value));
                                    _webViewController!.getOptions().then(
                                      (value) {
                                        value.crossPlatform
                                                .useShouldInterceptAjaxRequest =
                                            true;
                                        value.crossPlatform
                                                .javaScriptCanOpenWindowsAutomatically =
                                            true;
                                        value.crossPlatform.debuggingEnabled =
                                            true;
                                      },
                                    );
                                    _webViewController!.clearCache();
                                  },
                                  onProgressChanged:
                                      (InAppWebViewController controller,
                                          int progress) {
                                    setState(
                                      () {
                                        this.progress = progress / 100;
                                      },
                                    );
                                  },
                                  onConsoleMessage:
                                      (InAppWebViewController controller,
                                          ConsoleMessage consoleMessage) {
                                    print(
                                        "console message: ${consoleMessage.message}");
                                  })),
                        )
                      : CircularProgressIndicator()
            ],
          ),
        ),
        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         ListTile(
        //           title: Container(
        //             child: Column(
        //               children: [
        //                 Row(
        //                   children: [
        //                     Icon(
        //                       Icons.check_circle,
        //                       color: Colors.green,
        //                       size: Dimension.icon_size_medium,
        //                     ),
        //                     SizedBox(
        //                       width: 10.0,
        //                     ),
        //                     Text(
        //                       "Jon Roth",
        //                       style: TextStyle(
        //                         fontSize: Dimension.text_size_medium_large,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: [
        //                     Text(
        //                       "Drywall",
        //                       style: TextStyle(
        //                         fontSize: Dimension.text_size_extra_large,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 15.0,
        //         ),
        //         Divider(
        //           thickness: 1.0,
        //           color: Colors.grey,
        //         ),
        //         Container(
        //           child: Column(
        //             children: [
        //               ListTile(
        //                 title: Text("Career Level"),
        //                 trailing: Text("Medium Level"),
        //               ),
        //               Divider(
        //                 thickness: 1.0,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 title: Text("Location"),
        //                 trailing: Text("Medium Level"),
        //               ),
        //               Divider(
        //                 thickness: 1.0,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 title: Text("Job Type"),
        //                 trailing: Text("Medium Level"),
        //               ),
        //               Divider(
        //                 thickness: 1.0,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 title: Text("Duration"),
        //                 trailing: Text("Medium Level"),
        //               ),
        //               Divider(
        //                 thickness: 1.0,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 title: Text("Amount"),
        //                 trailing: Text("Medium Level"),
        //               ),
        //               Divider(
        //                 thickness: 1.0,
        //                 color: Colors.grey,
        //               ),
        //             ],
        //           ),
        //         ),
        //         ListTile(
        //           title: Text("Project Details"),
        //           subtitle: Text("Need a professional drywall finisher"),
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         Center(
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               GestureDetector(
        //                 color: Colors.blue[700],
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(6.0),
        //                 ),
        //                 onPressed: () {
        //                   Get.toNamed(AppRoutes.JOBDETAILSENDPROPOSAL);
        //                   print("Send Proposal");
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(12.0),
        //                   child: Text(
        //                     "Send Proposal",
        //                     style: TextStyle(
        //                       color: AppColors.backgroundColor,
        //                       fontSize: Dimension.text_size_medium,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               GestureDetector(
        //                 color: Colors.green,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(6.0),
        //                 ),
        //                 onPressed: () {
        //                   print("Apply Filter");
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(12.0),
        //                   child: Icon(
        //                     Icons.share,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //               GestureDetector(
        //                 color: Colors.blue[900],
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(6.0),
        //                 ),
        //                 onPressed: () {
        //                   print("Apply Filter");
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(12.0),
        //                   child: Icon(
        //                     Icons.warning,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
