import 'package:flutter/material.dart';

import 'home_page.dart';
import 'http_utils.dart';

void main() {
  initHttp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo of diox_log',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(title: 'Demo of diox_log'),
    );
  }
}
