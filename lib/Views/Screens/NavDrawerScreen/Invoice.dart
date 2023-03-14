import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/WebAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../../main.dart';

class Invoices extends StatefulWidget {
  Invoices({Key? key}) : super(key: key);

  @override
  _InvoicesState createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  InAppWebViewController? _webViewController;
  String url2 = "";
  double progress = 0;

    Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController!.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }
  @override
  Widget build(BuildContext context) {
    url2 = AppUrl.contractorInvoiceUrl;
    print("Check :::" + url2);
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
        var a ;
        return a;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Invoices"),),
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
                    initialUrl:
                        userMap!["user_info"]["role_name"] == "contractor"
                            ? AppUrl.contractorInvoiceUrl+ SharedPref.to.prefss!.getString("token")!
                            : AppUrl.vendorInvoiceUrl + SharedPref.to.prefss!.getString("token")!,
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          cacheEnabled: true,
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
                      _webViewController!.getOptions().then(
                        (value) {
                          value.crossPlatform.useShouldInterceptAjaxRequest =
                              true;
                          value.crossPlatform
                              .javaScriptCanOpenWindowsAutomatically = true;
                          value.crossPlatform.debuggingEnabled = true;
                        },
                      );
                      print("onLoadStart" + url);
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                      // (InAppWebViewController controller, String origin, List<String> resources) async {
                      //   return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                    //  },
                    },
                    onLoadStop: (InAppWebViewController controller,
                        String url) async {
                      print("onLoadStop" + url);
                      _webViewController!
                          .getUrl()
                          .then((value) => print(value));
                      _webViewController!.getOptions().then(
                        (value) {
                          value.crossPlatform.useShouldInterceptAjaxRequest =
                              true;
                          value.crossPlatform
                              .javaScriptCanOpenWindowsAutomatically = true;
                          value.crossPlatform.debuggingEnabled = true;
                        },
                      );
                    },
                    shouldOverrideUrlLoading:
                        (controller, shouldOverrideUrlLoadingRequest) async {
                      print("URL: ${shouldOverrideUrlLoadingRequest.url}");
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
            ],
          ),
        ),
      ),
    );
  }
}
