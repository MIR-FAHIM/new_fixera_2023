import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/InAppPurchase/in_app_purchase.dart';
import 'package:new_fixera/Views/InAppPurchase/payment_service.dart';
import 'package:new_fixera/Views/Widget/WebAppbar.dart';

import '../../../main.dart';
import 'package:new_fixera/Views/Widget/NormalAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'dart:io';

class PackagesScreen extends StatefulWidget {
  PackagesScreen({Key? key}) : super(key: key);

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  InAppWebViewController? _webViewController;
  double progress = 0;





  Future<void> _onRefresh() async {

    //practice



    //practice
    print("my user map is ------ $userMap");

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
          _webViewController!.canGoBack().then((value) {
            if (value) {
              _webViewController!.goBack();
            } else {
              Get.back();
            }
          });
        }
        var a;
        return a;
      },
      child: Scaffold(
          appBar:AppBar(title: Text("packages"),),
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
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                    child: InAppWebView(
                      initialHeaders: MyApiClient.header2(),
                      initialUrl:
                          userMap!["user_info"]["role_name"] == "contractor"
                              ? AppUrl.contractorPackagesUrl +
                                  SharedPref.to.prefss!.getString("token")!
                              : AppUrl.vendorPackagesUrl +
                                  SharedPref.to.prefss!.getString("token")!,
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                            useShouldOverrideUrlLoading: true),
                        android: AndroidInAppWebViewOptions(
                            // on Android you need to set supportMultipleWindows to true,
                            // otherwise the onCreateWindow event won't be called
                            supportMultipleWindows: true),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        // setState(() {
                        //   this.url2=url;
                        // });
                        _webViewController!.clearCache();
                        _webViewController!.getOptions().then((value) {
                          value.crossPlatform.useShouldInterceptAjaxRequest =
                              true;
                          value.crossPlatform
                              .javaScriptCanOpenWindowsAutomatically = true;
                          value.crossPlatform.debuggingEnabled = true;
                        });
                        //print("onLoadStart" + url);
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
                        _webViewController!
                            .getUrl()
                            .then((value) => print(value));
                        _webViewController!.getOptions().then((value) {
                          value.crossPlatform.useShouldInterceptAjaxRequest =
                              true;
                          value.crossPlatform
                              .javaScriptCanOpenWindowsAutomatically = true;
                          value.crossPlatform.debuggingEnabled = true;
                        });
                        _webViewController!.clearCache();
                        // if (url.contains(
                        //     "http://www.fix-era.com/contractor/dashboard/manage-jobs")) {
                        //   Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
                        // }
                      },
                      shouldOverrideUrlLoading:
                          (controller, shouldOverrideUrlLoadingRequest) async {
                        //   print("URL: ${shouldOverrideUrlLoadingRequest.url}");
                        _webViewController!.clearCache();

                        if (Platform.isAndroid) {
                          print(
                              "MY URL is -------------------------${shouldOverrideUrlLoadingRequest.url}");
                          if(shouldOverrideUrlLoadingRequest.url
                              .contains("https://www.fix-era.com/api/v1/webview/contractor")) {
                            print("iOS button url is +++++++++++++++++++++++++++++++++++++++++ " +
                                shouldOverrideUrlLoadingRequest.url);
                            Get.toNamed(AppRoutes.BOTTOMNAVIGATIONPAGE) ;

                          }
                          final a =
                              Uri.parse(shouldOverrideUrlLoadingRequest.url);

                          print("MY URL working");
                          print(
                              "My package id is +++++++ ${a.pathSegments.last}");
                          print("going for android");
                          controller.loadUrl(
                              url: shouldOverrideUrlLoadingRequest.url +
                                  SharedPref.to.prefss!.getString("token")!,
                              headers: MyApiClient.header2());
                          print("iOS button url is +++++++++++++++++++++++++++++++++++++++++ " +
                              shouldOverrideUrlLoadingRequest.url);

                          return ShouldOverrideUrlLoadingAction.CANCEL;


                        }
                        else if (Platform.isIOS) {
                          print("Platform is iOS");

                          print(
                              "Redirected URL: ${shouldOverrideUrlLoadingRequest.url}");

                          if (shouldOverrideUrlLoadingRequest.url
                              .contains("v1/webview/package/checkout")) {
                            print("iOS button url is " +
                                shouldOverrideUrlLoadingRequest.url);
                            //  print("MY URL is -------------------------${shouldOverrideUrlLoadingRequest.url.contains("v1/webview/package/checkout")}");
                            final a =
                                Uri.parse(shouldOverrideUrlLoadingRequest.url);
                            print(
                                "My package id is +++++++ ${a.pathSegments.last.toString()}");

                            // get/store
                            // user type userMap["user_info"]["role_name"]
                            //  user ID
                            // isPackageType= true or false
                            // packageID = shouldOverrideUrlLoadingRequest.url.substring("https://www.fix-era.com/api/v1/webview/package/checkout/","")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPayApp(
                                    purchaseType: true,
                                    userID: userMap!["user_info"]["id"],

                                    packageID: a.pathSegments.last,
                                  ),
                                ));
                            // Get.toNamed(AppRoutes.INAPPPURCHASE);

                            return ShouldOverrideUrlLoadingAction.CANCEL;
                          }

                          else{
                            Get.toNamed(AppRoutes.BOTTOMNAVIGATIONPAGE) ;
                          }
                        }

                        Uri url = Uri.parse(
                            'https://www.fix-era.com/api/v1/webview/package/checkout/');
                        print(
                            "My package id is +++++++++++${url.queryParametersAll['userid']![0]}");
                        print("new else else else +++++++++++++++++++++");

                        return ShouldOverrideUrlLoadingAction.ALLOW;
                      },
                      onConsoleMessage: (InAppWebViewController controller,
                          ConsoleMessage consoleMessage) {
                        print("console message: ${consoleMessage.message}");
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     child: InAppWebView(
                //       initialHeaders: MyApiClient.header2(),
                //       initialUrl:
                //           userMap["user_info"]["role_name"] == "contractor"
                //               ? AppUrl.contractorPackagesUrl
                //               : AppUrl.vendorPackagesUrl,
                //       initialOptions: InAppWebViewGroupOptions(
                //           crossPlatform: InAppWebViewOptions(
                //         debuggingEnabled: true,
                //       )),
                //       onWebViewCreated:
                //           (InAppWebViewController controller) async {
                //         _webViewController = controller;
                //       },
                //       onLoadStart:
                //           (InAppWebViewController controller, String url) {
                //         _webViewController.clearCache();
                //         _webViewController.getOptions().then((value) {
                //           value.crossPlatform.useShouldInterceptAjaxRequest =
                //               true;
                //           value.crossPlatform
                //               .javaScriptCanOpenWindowsAutomatically = true;
                //           value.crossPlatform.debuggingEnabled = true;
                //         });
                //         print("onLoadStart" + url);
                //       },
                //       androidOnPermissionRequest:
                //           (controller, origin, resources) async {
                //         return PermissionRequestResponse(
                //             resources: resources,
                //             action: PermissionRequestResponseAction.GRANT);
                //       },
                //       onLoadStop: (InAppWebViewController controller,
                //           String url) async {
                //         print("onLoadStop" + url);
                //         _webViewController
                //             .getUrl()
                //             .then((value) => print(value));
                //         _webViewController.getOptions().then((value) {
                //           value.crossPlatform.useShouldInterceptAjaxRequest =
                //               true;
                //           value.crossPlatform
                //               .javaScriptCanOpenWindowsAutomatically = true;
                //           value.crossPlatform.debuggingEnabled = true;
                //         });
                //         _webViewController.clearCache();
                //         if (url.contains(
                //             "http://www.fix-era.com/contractor/dashboard/manage-jobs")) {
                //           Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
                //         }
                //       },
                //       shouldOverrideUrlLoading:
                //           (controller, shouldOverrideUrlLoadingRequest) async {
                //         print("URL: ${shouldOverrideUrlLoadingRequest.url}");
                //         _webViewController.clearCache();

                //         if (Platform.isAndroid ||
                //             shouldOverrideUrlLoadingRequest
                //                     .iosWKNavigationType ==
                //                 IOSWKNavigationType.LINK_ACTIVATED) {
                //           controller.loadUrl(
                //               url: shouldOverrideUrlLoadingRequest.url,
                //               headers: MyApiClient.header2());
                //           return ShouldOverrideUrlLoadingAction.CANCEL;
                //         }
                //         return ShouldOverrideUrlLoadingAction.ALLOW;
                //       },
                //       onConsoleMessage: (InAppWebViewController controller,
                //           ConsoleMessage consoleMessage) async {
                //         print("console message: ${consoleMessage.message}");
                //       },
                //       onProgressChanged:
                //           (InAppWebViewController controller, int progress) {
                //         setState(() {
                //           this.progress = progress / 100;
                //         });
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          )
          // Container(
          //   height: Get.height,
          //   width: Get.width,
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           ListTile(
          //               title: Text('Basic',
          //                   style: TextStyle(
          //                       color: Color(0xff2ECC71),
          //                       fontSize: Dimension.text_size_medium_large,
          //                       fontWeight: FontWeight.bold)),
          //               subtitle: Text(
          //                 'Extended Plan For Manageria6l',
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               trailing: Container(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       mainAxisSize: MainAxisSize.min,
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Padding(
          //                           padding: const EdgeInsets.only(top: 5),
          //                           child: Text(
          //                             '\$',
          //                             style: TextStyle(
          //                                 color: Colors.black,
          //                                 fontSize: Dimension.text_size_small,
          //                                 fontWeight: FontWeight.w900),
          //                           ),
          //                         ),
          //                         Text(
          //                           '60',
          //                           style: TextStyle(
          //                               color: Colors.blueAccent,
          //                               fontSize:
          //                                   Dimension.text_size_extra1_large,
          //                               fontWeight: FontWeight.w900),
          //                         ),
          //                       ],
          //                     ),
          //                     Text(
          //                       '/month',
          //                       style: TextStyle(
          //                         fontSize: 12,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               )),
          //           Divider(
          //             height: 5,
          //             thickness: 2,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('No. Of Credits',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Text(
          //                 '60',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: Dimension.text_size_medium_large,
          //                     fontWeight: FontWeight.bold),
          //               )),
          //           Divider(
          //             height: 2,
          //             thickness: 1,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('No. Of Featured Jobs',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Text(
          //                 '15',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: Dimension.text_size_medium_large,
          //                     fontWeight: FontWeight.bold),
          //               )),
          //           Divider(
          //             height: 2,
          //             thickness: 1,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('Package Duration',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Text(
          //                 '1 Month',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: Dimension.text_size_medium_large,
          //                     fontWeight: FontWeight.bold),
          //               )),
          //           Divider(
          //             height: 2,
          //             thickness: 1,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('Badge',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Text(
          //                 'Gold',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: Dimension.text_size_medium_large,
          //                     fontWeight: FontWeight.bold),
          //               )),
          //           Divider(
          //             height: 2,
          //             thickness: 1,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('Banner',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Icon(
          //                 Icons.check,
          //                 color: Color(0xff2ECC71),
          //               )),
          //           Divider(
          //             height: 2,
          //             thickness: 1,
          //             color: Colors.grey,
          //           ),
          //           ListTile(
          //               title: Text('Private Chat',
          //                   style: TextStyle(
          //                     fontSize: Dimension.text_size_medium_large,
          //                   )),
          //               trailing: Icon(
          //                 Icons.check,
          //                 color: Color(0xff2ECC71),
          //               )),
          //           Divider(
          //             height: 5,
          //             thickness: 2,
          //             color: Colors.grey,
          //           ),
          //           SizedBox(height: 20),
          //           GestureDetector(
          //             onPressed: () {},
          //             color: Color(0xff2ECC71),
          //             child: Text(
          //               'BUY NOW',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: Dimension.text_size_medium_large,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
