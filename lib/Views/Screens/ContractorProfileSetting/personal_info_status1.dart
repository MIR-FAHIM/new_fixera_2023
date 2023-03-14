import 'package:new_fixera/Provider/apiProvider.dart';
import 'package:new_fixera/SharedPreferance/shared_preferance.dart';
import 'package:new_fixera/Views/Screens/BottomNavigationScreen/BottomNavigationPage.dart';
import 'package:new_fixera/Views/Screens/Signin/SignInPage.dart';
import 'package:new_fixera/Views/Screens/Signin/SplashPage.dart';
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ContractorPayStatus1 extends StatefulWidget {

  @override
  _ContractorPayStatus1State createState() => _ContractorPayStatus1State();
}

class _ContractorPayStatus1State extends State<ContractorPayStatus1> {
  var personalDetailUrl =
      "https://www.fix-era.com/api/v1/webview/contractor/profile?token=";

  InAppWebViewController? _webViewController;
  double progress = 0;


  @override
  Widget build(BuildContext context) {
    print("IIIIIII AMMMMMMM CONTRACTORRRRRRRRRRRR");
    return WillPopScope(
      onWillPop: () {
        Get.to(SignInPage());
        var a;

        return a;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Get.to(SignInPage());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Personal Details & Skills"),
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(5.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: InAppWebView(
                initialHeaders: MyApiClient.header2(),
                initialUrl:
                personalDetailUrl + SharedPref.to.prefss!.getString("token")!,
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptCanOpenWindowsAutomatically: true,
                        useShouldOverrideUrlLoading: true),
                    android: AndroidInAppWebViewOptions(
                      // on Android you need to set supportMultipleWindows to true,
                      // otherwise the onCreateWindow event won't be called
                        supportMultipleWindows: true),

                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                    )

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
                  _webViewController!.clearCache();
                },
                shouldOverrideUrlLoading:
                    (controller, shouldOverrideUrlLoadingRequest) async {
                  print("URL: ${shouldOverrideUrlLoadingRequest.url}");

                  _webViewController!.clearCache();

                  //  no need to load url, always allow to navigate
                  // iOS image uploading from simulator is working.

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
