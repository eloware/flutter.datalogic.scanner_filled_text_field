import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner_filled_text_field/scanner_filled_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner test'),
      ),
      body: ScannerFilledTextField(
        callback: (value) {
          print(value);
        },
      ),
    );
  }
}
