import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> with AutomaticKeepAliveClientMixin {
  //final _controller = WebViewController()
  //..setJavaScriptMode(JavaScriptMode.unrestricted)
  //..loadRequest(Uri.parse('https://inxta.dashnyam.com'));

  @override
  void initState() {
    super.initState();
    //  WidgetsFlutterBinding.ensureInitialized();
    //  WebViewPlatform.instance;
  }

  @override
  void dispose() {
    //  _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Placeholder()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
