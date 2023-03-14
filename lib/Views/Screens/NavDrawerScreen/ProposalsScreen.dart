import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';

import 'package:new_fixera/Views/Widget/WebAppbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_fixera/Provider/apiProvider.dart';

import 'dart:io';

class ProposalsPage extends StatefulWidget {
  ProposalsPage({Key? key}) : super(key: key);

  @override
  _ProposalsPageState createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
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
          appBar: AppBar(title: Text("Proposals"),),
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
                    child: InAppWebView(
                      initialHeaders: MyApiClient.header2(),
                      initialUrl: AppUrl.contractorProposalsUrl+ SharedPref.to.prefss!.getString("token")!,
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
                      onWebViewCreated:
                          (InAppWebViewController controller) async {
                        _webViewController = controller;
                      },
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
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
                          value.crossPlatform
                              .useShouldInterceptAjaxRequest = true;
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
                      shouldOverrideUrlLoading: (controller,
                          shouldOverrideUrlLoadingRequest) async {
                        print(
                            "URL: ${shouldOverrideUrlLoadingRequest.url}");
                        _webViewController!.clearCache();

                        // if (Platform.isAndroid ||
                        //     shouldOverrideUrlLoadingRequest
                        //             .iosWKNavigationType ==
                        //         IOSWKNavigationType.LINK_ACTIVATED) {
                        //   controller.loadUrl(
                        //       url: shouldOverrideUrlLoadingRequest.url + SharedPref.to.prefss.getString("token"),
                        //       headers: MyApiClient.header2());
                        //   return ShouldOverrideUrlLoadingAction.CANCEL;
                        // }
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
                              String? url  =  SharedPref.to.prefss
                                  .getString("token");
                              controller.loadUrl(
                                  url: shouldOverrideUrlLoadingRequest.url +
                                      "?token=" + url!
                                     ,
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
                      },
                      onConsoleMessage: (InAppWebViewController controller,
                          ConsoleMessage consoleMessage) async {
                        print("console message: ${consoleMessage.message}");
                      },
                      onProgressChanged: (InAppWebViewController controller,
                          int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )

          // SingleChildScrollView(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //             top: 1.0,
          //             left: 1.0,
          //             right: 1.0,
          //             bottom: 0.0,
          //           ),
          //           child: GestureDetector(
          //             child: Stack(
          //               overflow: Overflow.visible,
          //               children: [
          //                 Card(
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(12.0),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceEvenly,
          //                           children: [
          //                             Container(
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     "Job Titles",
          //                                     style: TextStyle(
          //                                         fontSize: Dimension
          //                                             .text_size_medium_large),
          //                                   ),
          //                                   Text(
          //                                     "Job Category Name",
          //                                     style: TextStyle(
          //                                         fontSize: Dimension
          //                                             .text_size_semi_medium),
          //                                   ),
          //                                   SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         FontAwesomeIcons.dollarSign,
          //                                         color: Colors.green,
          //                                         size: Dimension
          //                                             .icon_size_medium,
          //                                       ),
          //                                       SizedBox(
          //                                         width: 15.0,
          //                                       ),
          //                                       Text(
          //                                         "7850",
          //                                         style: TextStyle(
          //                                             fontSize: Dimension
          //                                                 .text_size_semi_medium),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         FontAwesomeIcons.flag,
          //                                         size: Dimension
          //                                             .icon_size_medium,
          //                                       ),
          //                                       SizedBox(
          //                                         width: 15.0,
          //                                       ),
          //                                       Text(
          //                                         "United States",
          //                                         style: TextStyle(
          //                                             fontSize: Dimension
          //                                                 .text_size_semi_medium),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         Icons.copy,
          //                                         color: Colors.blue,
          //                                         size: Dimension
          //                                             .icon_size_medium,
          //                                       ),
          //                                       SizedBox(
          //                                         width: 15.0,
          //                                       ),
          //                                       Text(
          //                                         "fixed",
          //                                         style: TextStyle(
          //                                             fontSize: Dimension
          //                                                 .text_size_semi_medium),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Row(
          //                                     children: [
          //                                       Icon(
          //                                         Icons.access_time_outlined,
          //                                         color: Colors.red,
          //                                         size: Dimension
          //                                             .icon_size_medium,
          //                                       ),
          //                                       SizedBox(
          //                                         width: 15.0,
          //                                       ),
          //                                       Text(
          //                                         "Less than a week",
          //                                         style: TextStyle(
          //                                             fontSize: Dimension
          //                                                 .text_size_semi_medium),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             Padding(
          //                               padding:
          //                                   const EdgeInsets.only(top: 60),
          //                               child: Row(
          //                                 children: [
          //                                   Container(
          //                                     color: Colors.black,
          //                                     height: 120,
          //                                     width: 2,
          //                                   ),
          //                                   Padding(
          //                                     padding:
          //                                         const EdgeInsets.symmetric(
          //                                             horizontal: 8),
          //                                     child: Column(
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Row(
          //                                           children: [
          //                                             Icon(
          //                                               Icons.check_circle,
          //                                               color: Colors.green,
          //                                               size: Dimension
          //                                                   .icon_size_small,
          //                                             ),
          //                                             SizedBox(
          //                                               width: 1.0,
          //                                             ),
          //                                             Text(
          //                                               "Abu Sayed",
          //                                               style: TextStyle(
          //                                                 fontSize: Dimension
          //                                                     .text_size_semi_medium,
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                         SizedBox(
          //                                           height: 20.0,
          //                                         ),
          //                                         Row(
          //                                           children: [
          //                                             GestureDetector(
          //                                               child: Text(
          //                                                 "Open Jobs",
          //                                                 style: TextStyle(
          //                                                     color:
          //                                                         Colors.blue,
          //                                                     fontSize: 12),
          //                                               ),
          //                                               onTap: () {
          //                                                 Get.toNamed(
          //                                                     AppRoutes.JOB);
          //                                               },
          //                                             ),
          //                                             SizedBox(
          //                                               width: 5.0,
          //                                             ),
          //                                             Container(
          //                                               width: 1,
          //                                               height: 20.0,
          //                                               color: Colors.blue,
          //                                             ),
          //                                             SizedBox(
          //                                               width: 5.0,
          //                                             ),
          //                                             GestureDetector(
          //                                               child: Text(
          //                                                 "Full Profile",
          //                                                 style: TextStyle(
          //                                                     color:
          //                                                         Colors.blue,
          //                                                     fontSize: 12),
          //                                               ),
          //                                               onTap: () {},
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   )
          //                                 ],
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                         SizedBox(
          //                           height: 10,
          //                         ),
          //                         Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceEvenly,
          //                           children: [
          //                             GestureDetector(
          //                               onPressed: () {
          //                                 Get.toNamed(
          //                                     AppRoutes.WORKORDERVENDOR);
          //                               },
          //                               color: Color(0xff2ECC71),
          //                               child: Text(
          //                                 'View work Order',
          //                                 style: TextStyle(
          //                                   color: Colors.white,
          //                                   fontSize: Dimension
          //                                       .text_size_semi_medium,
          //                                 ),
          //                               ),
          //                             ),
          //                             GestureDetector(
          //                               onPressed: () {},
          //                               color: Colors.blue,
          //                               child: Text(
          //                                 'Accept & Start',
          //                                 style: TextStyle(
          //                                   color: Colors.white,
          //                                   fontSize: Dimension
          //                                       .text_size_semi_medium,
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             onTap: () {
          //               Get.toNamed(AppRoutes.JOBDETAILSPAGE);
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          ),
    );
  }
}
