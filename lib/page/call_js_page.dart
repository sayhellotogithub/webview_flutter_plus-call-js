import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CallJsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CallJsPageState();
  }
}

class _CallJsPageState extends State<CallJsPage> {
  WebViewPlusController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter web call js"),
      ),
      body: WebViewPlus(
        onWebViewCreated: (controller) {
          _controller = controller;
          controller.loadUrl('assets/index.html');
        },
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
              name: "messageHandler",
              onMessageReceived: (JavascriptMessage message) {
                print(message);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message.message),
                ));
              })
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _controller?.webViewController
              .evaluateJavascript("fromFlutter('from flutter')");
        },
      ),
    );
  }
}
