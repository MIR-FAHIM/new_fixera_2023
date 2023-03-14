import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/InAppPurchase/in_app_purchase.dart';
import 'package:new_fixera/Views/InAppPurchase/payment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/ExportUtilities.dart';
import 'package:new_fixera/Views/Widget/WebAppbar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class BuyCredit extends StatefulWidget {
  BuyCredit({Key? key}) : super(key: key);

  @override
  _BuyCreditState createState() => _BuyCreditState();
}

class _BuyCreditState extends State<BuyCredit> {
  InAppWebViewController? _webViewController;
  double progress = 0;

  Future<void> _onRefresh() async {
    if (_webViewController != null) {
      _webViewController?.reload();
    }
    await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_webViewController != null) {
          _webViewController?.canGoBack().then((value) {
            if (value) {
              _webViewController?.goBack();
            } else {
              Get.back();
            }
          });
        }
        var a;
        return a;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Buy Credit"),),
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
                    : Container(),
              ),
              Expanded(
                child: Container(
                  child: InAppWebView(
                    initialHeaders: MyApiClient.header2(),
                    initialUrl: AppUrl.buyCreditUrl+ SharedPref.to.prefss!.getString("token")!,

                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          javaScriptCanOpenWindowsAutomatically: true,
                          useShouldOverrideUrlLoading: true),
                      android: AndroidInAppWebViewOptions(
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
                      print(url.substring(1, 53));
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
                      print(url.substring(1, 53));
                      _webViewController!.getUrl().then((url) {
                        print("substring");
                        print(url.substring(1, 53));
                      });
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

      if (Platform.isAndroid) {
        print("Buy Credit URL: ${shouldOverrideUrlLoadingRequest.url}");
                        controller.loadUrl(
                            url: shouldOverrideUrlLoadingRequest.url+ SharedPref.to.prefss!.getString("token")!,
                            headers: MyApiClient.header2());
        print ("Platform is iOS");

        print("Buy Credit URL: ${shouldOverrideUrlLoadingRequest.url}");


        // if(shouldOverrideUrlLoadingRequest.url.contains("https://pci-connect.squareup.com/v2/iframe"))
        // {
        //
        //   print("iOS button url is "+ shouldOverrideUrlLoadingRequest.url);
        //
        //   // get/store
        //   // user type userMap["user_info"]["role_name"]
        //   //  user ID ==
        //   // isPackageType= false, true or false
        //   // packageID = 0
        //
        //   Get.off(MyPayApp(purchaseType: false, userID: userMap["user_info"]["id"], packageID: "0",));
        //
        //
        //
          return ShouldOverrideUrlLoadingAction.CANCEL;
        //
        // }

                      } else if (Platform.isIOS)
                      {

                        print ("Platform is iOS");

                        print("Buy Credit URL: ${shouldOverrideUrlLoadingRequest.url}");


                        if(shouldOverrideUrlLoadingRequest.url.contains("https://pci-connect.squareup.com/v2/iframe"))
                        {

                          print("iOS button url is "+ shouldOverrideUrlLoadingRequest.url);

                          // get/store
                          // user type userMap["user_info"]["role_name"]
                          //  user ID ==
                          // isPackageType= false, true or false
                          // packageID = 0

                          Get.off(MyPayApp(purchaseType: false, userID: userMap!["user_info"]["id"], packageID: "0",));



                          return ShouldOverrideUrlLoadingAction.CANCEL;

                        }

                      }

                      return ShouldOverrideUrlLoadingAction.ALLOW;
                      return ShouldOverrideUrlLoadingAction.CANCEL;
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
