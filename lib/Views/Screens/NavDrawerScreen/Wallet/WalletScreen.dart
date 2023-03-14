import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/ExportWidget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  InAppWebViewController? _webViewController;
  TabController? tabController;
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text("Wallet"),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              // controller: tabController,
              tabs: [
                Tab(text: "Withdraw"),
                Tab(text: "Transfer History"),
                Tab(text: "Income History")
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              //  Withdraw
              Container(
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
                          initialUrl: AppUrl.withdrawUrl+ SharedPref.to.prefss!.getString("token")!,
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                                debuggingEnabled: true,
                                javaScriptCanOpenWindowsAutomatically: true,
                                useShouldOverrideUrlLoading: true),
                            android: AndroidInAppWebViewOptions(
                                supportMultipleWindows: true),
                          ),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          onLoadStart: (InAppWebViewController controller,
                              String url) {
                            _webViewController!.clearCache();

                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            print("onLoadStart" + url);
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action:
                                    PermissionRequestResponseAction.GRANT);
                          },
                          onLoadStop: (InAppWebViewController controller,
                              String url) async {
                            print("onLoadStop" + url);

                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            _webViewController!.clearCache();
                          },
                          shouldOverrideUrlLoading: (controller,
                              shouldOverrideUrlLoadingRequest) async {
                            print(
                                "URL: ${shouldOverrideUrlLoadingRequest.url}");

                            if (Platform.isAndroid ||
                                shouldOverrideUrlLoadingRequest
                                        .iosWKNavigationType ==
                                    IOSWKNavigationType.LINK_ACTIVATED) {
                              controller.loadUrl(
                                  url: shouldOverrideUrlLoadingRequest.url+ SharedPref.to.prefss!.getString("token")!,
                                  headers: {
                                    'Authorization':
                                        '${userMap!["token_type"]} ${userMap!["access_token"]}'
                                  });
                              return ShouldOverrideUrlLoadingAction.CANCEL;
                            }
                            return ShouldOverrideUrlLoadingAction.ALLOW;
                          },
                          onConsoleMessage:
                              (InAppWebViewController controller,
                                  ConsoleMessage consoleMessage) {
                            print(
                                "console message: ${consoleMessage.message}");
                          },
                          onProgressChanged:
                              (InAppWebViewController controller,
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
              ),

              //Transfer History
              Container(
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
                          initialUrl: AppUrl.transferHistoryUrl+ SharedPref.to.prefss!.getString("token")!,
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
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          onLoadStart: (InAppWebViewController controller,
                              String url) {
                            // setState(() {
                            //   this.url2=url;
                            // });
                            _webViewController!.clearCache();
                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            print("onLoadStart" + url);
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action:
                                    PermissionRequestResponseAction.GRANT);
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
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            _webViewController!.clearCache();
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
                                  url: shouldOverrideUrlLoadingRequest.url+ SharedPref.to.prefss!.getString("token")!,
                                  headers: MyApiClient.header2());
                              return ShouldOverrideUrlLoadingAction.CANCEL;
                            }
                            return ShouldOverrideUrlLoadingAction.ALLOW;
                          },
                          onConsoleMessage:
                              (InAppWebViewController controller,
                                  ConsoleMessage consoleMessage) {
                            print(
                                "console message: ${consoleMessage.message}");
                          },
                          onProgressChanged:
                              (InAppWebViewController controller,
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
              ),
              //Income History
              Container(
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
                          initialUrl: AppUrl.incomeHistoryUrl + SharedPref.to.prefss!.getString("token")!,
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
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          onLoadStart: (InAppWebViewController controller,
                              String url) {
                            // setState(() {
                            //   this.url2=url;
                            // });
                            _webViewController!.clearCache();
                            _webViewController!.getOptions().then((value) {
                              value.crossPlatform
                                  .useShouldInterceptAjaxRequest = true;
                              value.crossPlatform
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
                              value.crossPlatform.debuggingEnabled = true;
                            });
                            print("onLoadStart" + url);
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action:
                                    PermissionRequestResponseAction.GRANT);
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
                                      .javaScriptCanOpenWindowsAutomatically =
                                  true;
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

                            if (Platform.isAndroid ||
                                shouldOverrideUrlLoadingRequest
                                        .iosWKNavigationType ==
                                    IOSWKNavigationType.LINK_ACTIVATED) {
                              controller.loadUrl(
                                  url: shouldOverrideUrlLoadingRequest.url+ SharedPref.to.prefss!.getString("token")!,
                                  headers: MyApiClient.header2());
                              return ShouldOverrideUrlLoadingAction.CANCEL;
                            }
                            return ShouldOverrideUrlLoadingAction.ALLOW;
                          },
                          onConsoleMessage:
                              (InAppWebViewController controller,
                                  ConsoleMessage consoleMessage) {
                            print(
                                "console message: ${consoleMessage.message}");
                          },
                          onProgressChanged:
                              (InAppWebViewController controller,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
