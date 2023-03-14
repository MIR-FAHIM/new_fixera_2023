import 'dart:io';

import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VendorProfileDetailScreen extends StatefulWidget {
  @override
  _VendorProfileDetailScreenState createState() =>
      _VendorProfileDetailScreenState();
}

class _VendorProfileDetailScreenState extends State<VendorProfileDetailScreen> {
  InAppWebViewController? _webViewController;
  double? progress;
  var vendorProfileSettingUrl =
      "https://www.fix-era.com/api/v1/webview/vendor/profile";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
         Route route = MaterialPageRoute(builder: (c) => BottomNavigationPage());
        Navigator.pushReplacement(context, route);
        var a ;
        return a;

      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (c) => BottomNavigationPage());
              Navigator.pushReplacement(context, route);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Personal Details & Skills"),
        ),
        body: Column(
          children: [
/*          Container(
                padding: EdgeInsets.all(5.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),*/
            Expanded(
              child: InAppWebView(
                initialHeaders: MyApiClient.header2(),
                initialUrl: vendorProfileSettingUrl,
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

                  if (Platform.isAndroid ||
                      shouldOverrideUrlLoadingRequest.iosWKNavigationType ==
                          IOSWKNavigationType.LINK_ACTIVATED) {
                    controller.loadUrl(
                        url: shouldOverrideUrlLoadingRequest.url,
                        headers: MyApiClient.header2());
                    return ShouldOverrideUrlLoadingAction.CANCEL;
                  }
                  return ShouldOverrideUrlLoadingAction.ALLOW;
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