import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:new_fixera/Views/Widget/WebAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../main.dart';



class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>

{
  InAppWebViewController? _webViewController;
  double progress = 0;


  Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController!.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_webViewController != null) {
          print("print Pressed");
          _webViewController!.canGoBack().then(
            (value) {
              if (value) {
                _webViewController!.goBack();
              } else {
                Get.back();
              }
            },
          );
        }
        var a;
        return a;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Dashboeard"),),
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
              Expanded(
                child: Container(
                  child:
                  InAppWebView(
                    initialHeaders: MyApiClient.header2(),
                    initialUrl:
                    userMap!["user_info"]["role_name"] == "contractor"
                        ? AppUrl.contractorDashBoardUrl + SharedPref.to.prefss!.getString("token")!
                        : AppUrl.vendorDashBoardUrl + SharedPref.to.prefss!.getString("token")!,

                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          javaScriptCanOpenWindowsAutomatically: true,
                          useShouldOverrideUrlLoading: true),
                      android: AndroidInAppWebViewOptions(
                          supportMultipleWindows: true),

                        ///TODO



                    ios: IOSInAppWebViewOptions(
                          allowsInlineMediaPlayback: true,

                        )


                    ),


                    onWebViewCreated: (InAppWebViewController controller) async {
                      _webViewController = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) {
                      //_webViewController.clearCache();
                      _webViewController!.getOptions().then((value) {
                        value.crossPlatform.useShouldInterceptAjaxRequest = true;
                        value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                        true;
                        value.crossPlatform.debuggingEnabled = true;
                      });
                      print("onLoadStart " + url);
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) async {
                      print("onLoadStop " + url);
                      _webViewController!.getUrl().then((value) => print(value));
                      _webViewController!.getOptions().then((value) {
                        value.crossPlatform.useShouldInterceptAjaxRequest = true;
                        value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                        true;
                        value.crossPlatform.debuggingEnabled = true;
                      });
                      // _webViewController.clearCache();
                    },
                    shouldOverrideUrlLoading:
                        (controller, shouldOverrideUrlLoadingRequest) async {



                          print(
                              "URL: ${shouldOverrideUrlLoadingRequest.url}");
                          _webViewController!.clearCache();

                          if (Platform.isAndroid ||
                              shouldOverrideUrlLoadingRequest
                                  .iosWKNavigationType ==
                                  IOSWKNavigationType.LINK_ACTIVATED) {
                            if (!shouldOverrideUrlLoadingRequest.url
                                .contains("token")) {
                              print("START");

                              if (shouldOverrideUrlLoadingRequest.url
                                  .contains("?page=")) {
                                controller.loadUrl(
                                    url: shouldOverrideUrlLoadingRequest.url +
                                        "&token=" +
                                        SharedPref.to.prefss!
                                            .getString("token")!,
                                    headers: MyApiClient.header2());
                              } else {
                                controller.loadUrl(
                                    url: shouldOverrideUrlLoadingRequest.url +
                                        "?token=" +
                                        SharedPref.to.prefss!
                                            .getString("token")!,
                                    headers: MyApiClient.header2());
                              }

                              return ShouldOverrideUrlLoadingAction.CANCEL;
                            } else {
                              final myString =
                                  shouldOverrideUrlLoadingRequest.url;
                              var newurl = myString.substring(
                                  0, myString.indexOf("&token="));

                              print("NEW URL" + newurl);
                            }
                          }
                          return ShouldOverrideUrlLoadingAction.ALLOW;








                      //print("URL: ${shouldOverrideUrlLoadingRequest.url}");
                      // _webViewController.clearCache();

                      // if (Platform.isAndroid ||
                      //     shouldOverrideUrlLoadingRequest.iosWKNavigationType ==
                      //         IOSWKNavigationType.LINK_ACTIVATED) {

                      // if(Platform.isAndroid) {
                      //   print("This is ANDROID");
                      //   if (shouldOverrideUrlLoadingRequest.url.contains(
                      //       "https://www.fix-era.com/api/v1/webview/vendor/dashboard/manage-jobs?page=")) {
                      //     controller.loadUrl(
                      //         url: shouldOverrideUrlLoadingRequest.url +
                      //             "&token=" +
                      //             SharedPref.to.prefss.getString("token"),
                      //         headers: MyApiClient.header2());
                      //     return ShouldOverrideUrlLoadingAction.CANCEL;
                      //   }
                      //   else if (shouldOverrideUrlLoadingRequest.url.contains(
                      //       "https://www.fix-era.com/api/v1/webview/proposals?page=")) {
                      //     controller.loadUrl(
                      //         url: shouldOverrideUrlLoadingRequest.url +
                      //             "&token=" +
                      //             SharedPref.to.prefss.getString("token"),
                      //         headers: MyApiClient.header2());
                      //     return ShouldOverrideUrlLoadingAction.CANCEL;
                      //   }
                      //
                      //   else {
                      //     controller.loadUrl(
                      //         url: shouldOverrideUrlLoadingRequest.url +
                      //             "?token=" +
                      //             SharedPref.to.prefss.getString("token"),
                      //         headers: MyApiClient.header2());
                      //     return ShouldOverrideUrlLoadingAction.CANCEL;
                      //   }
                      // }
                      //
                      // else if(Platform.isIOS)
                      //   {
                      //     print("This is biplob IOS");
                      //     print(SharedPref.to.prefss.getString("token"));
                      //     var redirecturl=shouldOverrideUrlLoadingRequest.url;
                      //     if (redirecturl.contains(
                      //         "https://www.fix-era.com/api/v1/webview/vendor/dashboard/manage-jobs?page=")) {
                      //
                      //       if(redirecturl.contains("token="))
                      //         {
                      //         controller.loadUrl(
                      //         url: redirecturl);
                      //
                      //         }else
                      //           {
                      //             controller.loadUrl(
                      //                 url: redirecturl +
                      //                     "&token=" +
                      //                     SharedPref.to.prefss.getString("token"));
                      //           }
                      //
                      //       return ShouldOverrideUrlLoadingAction.CANCEL;
                      //     }
                      //     else if (redirecturl.contains(
                      //         "https://www.fix-era.com/api/v1/webview/proposals?page=")) {
                      //       if(redirecturl.contains("token="))
                      //       {
                      //         controller.loadUrl(
                      //             url: redirecturl);
                      //
                      //       }else
                      //       {
                      //         controller.loadUrl(
                      //             url: redirecturl +
                      //                 "&token=" +
                      //                 SharedPref.to.prefss.getString("token"));
                      //       }
                      //       return ShouldOverrideUrlLoadingAction.CANCEL;
                      //     }
                      //
                      //     else {
                      //       print("Else");
                      //
                      //       if(redirecturl.contains("token="))
                      //       {
                      //         print("Else 1");
                      //         print(await controller.getUrl());
                      //
                      //
                      //           if (redirecturl != await controller.getUrl()) {
                      //             await controller.loadUrl(
                      //                 url: redirecturl);
                      //           }
                      //
                      //         return ShouldOverrideUrlLoadingAction.CANCEL;
                      //       }else
                      //       {
                      //         print("Else 2");
                      //         controller.loadUrl(
                      //             url: redirecturl +
                      //                 "?token=" +
                      //                 SharedPref.to.prefss.getString("token"),
                      //             );
                      //
                      //       }
                      //
                      //       return ShouldOverrideUrlLoadingAction.CANCEL;
                      //     }
                      //   }
                      //  }
                      //return ShouldOverrideUrlLoadingAction.ALLOW;
                    },
                    onConsoleMessage: (InAppWebViewController controller,
                        ConsoleMessage consoleMessage) async {
                      print("console message: ${consoleMessage.message}");
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),


                  // InAppWebView(
                  //   initialHeaders: MyApiClient.header2(),
                  //   initialUrl:
                  //   userMap["user_info"]["role_name"] == "contractor"
                  //       ? AppUrl.contractorDashBoardUrl
                  //       : AppUrl.vendorDashBoardUrl,
                  //   initialOptions: InAppWebViewGroupOptions(
                  //     crossPlatform: InAppWebViewOptions(
                  //         debuggingEnabled: true,
                  //         cacheEnabled: true,
                  //         javaScriptCanOpenWindowsAutomatically: true,
                  //         useShouldOverrideUrlLoading: true),
                  //     android: AndroidInAppWebViewOptions(
                  //         // on Android you need to set supportMultipleWindows to true,
                  //         // otherwise the onCreateWindow event won't be called
                  //         supportMultipleWindows: true),
                  //   ),
                  //   onWebViewCreated: (InAppWebViewController controller) {
                  //     _webViewController = controller;
                  //   },
                  //   onLoadStart:
                  //       (InAppWebViewController controller, String url) {
                  //     _webViewController.getOptions().then(
                  //       (value) {
                  //         value.crossPlatform.useShouldInterceptAjaxRequest =
                  //             true;
                  //         value.crossPlatform
                  //             .javaScriptCanOpenWindowsAutomatically = true;
                  //         value.crossPlatform.debuggingEnabled = true;
                  //       },
                  //     );
                  //     print("onLoadStart" + url);
                  //   },
                  //   androidOnPermissionRequest:
                  //       (controller, origin, resources) async {
                  //     return PermissionRequestResponse(
                  //         resources: resources,
                  //         action: PermissionRequestResponseAction.GRANT);
                  //   },
                  //   onLoadStop: (InAppWebViewController controller,
                  //       String url) async {
                  //     print("onLoadStop" + url);
                  //     _webViewController
                  //         .getUrl()
                  //         .then((value) => print(value));
                  //     _webViewController.getOptions().then(
                  //       (value) {
                  //         value.crossPlatform.useShouldInterceptAjaxRequest =
                  //             true;
                  //         value.crossPlatform
                  //             .javaScriptCanOpenWindowsAutomatically = true;
                  //         value.crossPlatform.debuggingEnabled = true;
                  //       },
                  //     );
                  //   },
                  //   shouldOverrideUrlLoading:
                  //       (controller, shouldOverrideUrlLoadingRequest) async {
                  //     print("URL: ${shouldOverrideUrlLoadingRequest.url}");
                  //     _webViewController.clearCache();
                  //
                  //     if (Platform.isAndroid ||
                  //         shouldOverrideUrlLoadingRequest
                  //                 .iosWKNavigationType ==
                  //             IOSWKNavigationType.LINK_ACTIVATED) {
                  //       controller.loadUrl(
                  //           url: shouldOverrideUrlLoadingRequest.url,
                  //           headers: MyApiClient.header2());
                  //       return ShouldOverrideUrlLoadingAction.CANCEL;
                  //     }
                  //     return ShouldOverrideUrlLoadingAction.ALLOW;
                  //   },
                  //   onConsoleMessage: (InAppWebViewController controller,
                  //       ConsoleMessage consoleMessage) {
                  //     print("console message: ${consoleMessage.message}");
                  //   },
                  //   onProgressChanged:
                  //       (InAppWebViewController controller, int progress) {
                  //     setState(
                  //       () {
                  //         this.progress = progress / 100;
                  //       },
                  //     );
                  //   },
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
