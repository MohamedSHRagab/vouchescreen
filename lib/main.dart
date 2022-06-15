import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucher/Auth.dart';
import 'package:voucher/network/ApiUrl.dart';
import 'package:voucher/network/HttpClient.dart';
import 'package:voucher/provider/AuthProvider.dart';
import 'package:voucher/screens%20/Auth.dart';
import 'package:voucher/screens%20/voucher.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Retail-Tec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Voucher_screen(),
      home: ApiUrl.auth_session == ""
          ? auth()
          : Voucher_screen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
