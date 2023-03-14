import 'dart:io';
import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Screens/Signin/SignInPage.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class DeactivateAccount extends StatefulWidget {
  DeactivateAccount({Key? key}) : super(key: key);

  @override
  _DeactivateAccountState createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  var payment_setting_url =
      "https://www.fix-era.com/api/v1/webview/profile/settings/delete-account?token=";

  InAppWebViewController? _webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    print("The token is ${MyApiClient.header2()}");
    print("The token is");

    return WillPopScope(
      onWillPop: () {
        Route route = MaterialPageRoute(builder: (c) => BottomNavigationPage());
        Navigator.pushReplacement(context, route);
        var a;

        return a;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Deactivate Account"),
        ),
        body: Column(
          children: [
/*          Container(
                padding: EdgeInsets.all(5.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),*/
            Container(
                padding: EdgeInsets.all(5.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: InAppWebView(
                initialHeaders: MyApiClient.header2(),
                initialUrl: payment_setting_url +
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
                onWebViewCreated: (InAppWebViewController controller) async {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  _webViewController!.clearCache();
                  _webViewController!.getOptions().then((value) {
                    value.crossPlatform.useShouldInterceptAjaxRequest = true;
                    value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                        true;
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
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  print("onLoadStop" + url);
                  _webViewController!.getUrl().then((value) => print(value));
                  _webViewController!.getOptions().then((value) {
                    value.crossPlatform.useShouldInterceptAjaxRequest = true;
                    value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
                        true;
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
                  print("URL: ${shouldOverrideUrlLoadingRequest.url}");
                  _webViewController!.clearCache();

                  print("shouldOverrideUrlLoadingRequest");

                  if (Platform.isAndroid ||
                      shouldOverrideUrlLoadingRequest.iosWKNavigationType ==
                          IOSWKNavigationType.LINK_ACTIVATED) {
                    if (shouldOverrideUrlLoadingRequest.url
                        .contains("https://fix-era.com/login")) {
                      print("User Deleted");
                      Get.off(SignInPage());
                      //return ShouldOverrideUrlLoadingAction.CANCEL;
                    } else {
                      print("abcd++++++++++++++++++");
                      //Get.off(SignInPage());
                      // controller.loadUrl(
                      //     url: shouldOverrideUrlLoadingRequest.url +"?token"+
                      //         SharedPref.to.prefss.getString("token"),
                      //     headers: MyApiClient.header2());
                      return ShouldOverrideUrlLoadingAction.CANCEL;
                    }
                  } else if (Platform.isIOS) {
                    if (shouldOverrideUrlLoadingRequest.url
                        .contains("https://fix-era.com/login")) {
                      print("User Deleted Ios");
                      Get.off(SignInPage());
                      //return ShouldOverrideUrlLoadingAction.CANCEL;
                    }
                  }
                  return ShouldOverrideUrlLoadingAction.CANCEL;
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
            ),
          ],
        ),
      ),
    );
  }
}
