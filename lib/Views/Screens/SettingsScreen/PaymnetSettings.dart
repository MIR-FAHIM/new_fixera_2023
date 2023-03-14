import 'dart:io';

import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:new_fixera/Views/Utilities/AppUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSettings extends StatefulWidget {
  PaymentSettings({Key? key}) : super(key: key);

  @override
  _PaymentSettingsState createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  var payment_setting_url =
      "https://www.fix-era.com/api/v1/webview/contractor/dashboard/payment-settings";

  InAppWebViewController? _webViewController;
  double? progress;

  @override
  Widget build(BuildContext context) {
    print("The token is ${MyApiClient.header2()}");
    print("The token is");

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Settings"),
      ),
      body: Column(
        children: [
/*          Container(
              padding: EdgeInsets.all(5.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),*/
          Expanded(child: load()
              // InAppWebView(
              //   initialHeaders: MyApiClient.header2(),
              //   initialUrl: payment_setting_url,
              //   initialOptions: InAppWebViewGroupOptions(
              //     crossPlatform: InAppWebViewOptions(
              //         debuggingEnabled: true,
              //         javaScriptCanOpenWindowsAutomatically: true,
              //         useShouldOverrideUrlLoading: true),
              //     android: AndroidInAppWebViewOptions(
              //         // on Android you need to set supportMultipleWindows to true,
              //         // otherwise the onCreateWindow event won't be called
              //         supportMultipleWindows: true),
              //   ),
              //   onWebViewCreated: (InAppWebViewController controller) async {
              //     _webViewController = controller;
              //   },
              //   onLoadStart: (InAppWebViewController controller, String url) {
              //     _webViewController.clearCache();
              //     _webViewController.getOptions().then((value) {
              //       value.crossPlatform.useShouldInterceptAjaxRequest = true;
              //       value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
              //           true;
              //       value.crossPlatform.debuggingEnabled = true;
              //     });
              //     print("onLoadStart" + url);
              //   },
              //   androidOnPermissionRequest:
              //       (controller, origin, resources) async {
              //     return PermissionRequestResponse(
              //         resources: resources,
              //         action: PermissionRequestResponseAction.GRANT);
              //   },
              //   onLoadStop:
              //       (InAppWebViewController controller, String url) async {
              //     print("onLoadStop" + url);
              //     _webViewController.getUrl().then((value) => print(value));
              //     _webViewController.getOptions().then((value) {
              //       value.crossPlatform.useShouldInterceptAjaxRequest = true;
              //       value.crossPlatform.javaScriptCanOpenWindowsAutomatically =
              //           true;
              //       value.crossPlatform.debuggingEnabled = true;
              //     });
              //     _webViewController.clearCache();
              //     // if (url.contains(
              //     //     "http://www.fix-era.com/contractor/dashboard/manage-jobs")) {
              //     //   Get.offAndToNamed(AppRoutes.BOTTOMNAVIGATIONPAGE);
              //     // }
              //   },
              //   shouldOverrideUrlLoading:
              //       (controller, shouldOverrideUrlLoadingRequest) async {
              //     print("URL: ${shouldOverrideUrlLoadingRequest.url}");
              //     _webViewController.clearCache();
              //
              //     if (Platform.isAndroid ||
              //         shouldOverrideUrlLoadingRequest.iosWKNavigationType ==
              //             IOSWKNavigationType.LINK_ACTIVATED) {
              //       controller.loadUrl(
              //           url: shouldOverrideUrlLoadingRequest.url,
              //           headers: MyApiClient.header2());
              //       return ShouldOverrideUrlLoadingAction.CANCEL;
              //     }
              //     return ShouldOverrideUrlLoadingAction.ALLOW;
              //   },
              //   onConsoleMessage: (InAppWebViewController controller,
              //       ConsoleMessage consoleMessage) async {
              //     print("console message: ${consoleMessage.message}");
              //   },
              //   onProgressChanged:
              //       (InAppWebViewController controller, int progress) {
              //     setState(() {
              //       this.progress = progress / 100;
              //     });
              //   },
              // ),
              ),
        ],
      ),
    );
  }

  load() {
    return WebviewScaffold(
        headers: MyApiClient.header2(),
        url: payment_setting_url,
        // appBar: new AppBar(
        //   title: const Text('Widget webview'),
        // ),
        withZoom: true,
        clearCache: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
