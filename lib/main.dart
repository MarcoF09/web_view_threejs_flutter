import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_assets_server/local_assets_server.dart';
import 'package:webviewthreejs/web_view_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isListening = false;
  String address;
  int port;

  @override
  initState() {
    _initServer();

    super.initState();
  }

  _initServer() async {
    final server = new LocalAssetsServer(
      address: InternetAddress.loopbackIPv4,
//      assetsBasePath: 'assets',
//      assetsBasePath: 'assets2',
        assetsBasePath: 'assets3',
    );

    final address = await server.serve();

    setState(() {
      this.address = address.address;
      port = server.boundPort;
      isListening = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isListening
          ? WebViewContainer('http://$address:$port')
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
