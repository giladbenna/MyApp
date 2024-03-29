import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider; // Hide ChangeNotifierProvider from Riverpod
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/views/FirstPage.dart';
import 'package:provider/provider.dart'; // No need to hide anything here as we're using ChangeNotifierProvider from this package

void main() {
  runApp(
    ProviderScope(
      // Initialize Riverpod
      child: ChangeNotifierProvider(
        // Provided by the 'provider' package
        create: (context) => CategoryProvider(),
        child: MyApp(),
      ),
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
