import 'package:flutter/material.dart';
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/views/FirstPage.dart';
import 'package:my_app/views/LoginPage.dart';
import 'package:my_app/views/MenuPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FirstPage(),
    );
  }
}
