import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigate',
      theme: ThemeData(
        brightness:Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lolly'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController controller;
  bool isLoading=true;
  String url="https://www.lollydapp.com/";
  final _key = UniqueKey();
  launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            WebView(
              key: _key,
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller){
                this.controller=controller;
              },
              onPageStarted: (url){
                print("new Website: $url");

              },
              onPageFinished: (finish){
                setState(() {
                  isLoading=false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            setState(() {
              if(isLoading){
                isLoading=false;
              }
              else{
                isLoading=true;
                controller.loadUrl(url);
              }

            });
            // controller.evaluateJavascript();
          //   await controller.runJavascriptReturningResult(
          //     "document.getElementsByTagName('header')[0].style.display='none'"
          //   );
          //   await controller.runJavascriptReturningResult(
          //       "document.getElementsByTagName('footer')[0].style.display='none'"
          //   );
          //   final url=await controller.currentUrl();
          //   print("previous url $url");
          //   controller.loadUrl("https://amazon.com");
          },
          tooltip: 'Refresh',
          child: const Icon(Icons.import_export,size: 32,),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
