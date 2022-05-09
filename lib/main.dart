import 'package:flutter/material.dart';
import 'package:voucher/screens%20/voucher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retail-Tec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Voucher_screen(),
    );
  }
}
