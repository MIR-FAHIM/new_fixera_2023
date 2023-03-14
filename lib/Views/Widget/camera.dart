import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class IframeScreen extends StatefulWidget {
  @override
  _IframeScreenState createState() => _IframeScreenState();
}

class _IframeScreenState extends State<IframeScreen> {
  InAppWebViewController? _webViewController;

  Future webViewMethod() async {
    print('In Microphone permission method');
    //WidgetsFlutterBinding.ensureInitialized();

    await Permission.microphone.request();
    WebViewMethodForCamera();

  }
  Future WebViewMethodForCamera() async{
    print('In Camera permission method');
    //WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Check this frame'),
        ),
        body: Column(
          children: <Widget>[
            GestureDetector(
              onTap: webViewMethod,
              child: Text('Join'),

            ),

            Expanded(
              child: Container(
                child: InAppWebView(
                    initialUrl: "https://appr.tc/r/158489234",
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        mediaPlaybackRequiresUserGesture: false,
                        debuggingEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest: (
                        InAppWebViewController controller, String origin,
                        List<String> resources) async {
                      return PermissionRequestResponse(resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    }
                ),
              ),
            )

          ],
        )
    );
  } }



class TestMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IframeScreen(),
    );
  }
}

