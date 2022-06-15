import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucher/Auth.dart';
import 'package:voucher/network/ApiUrl.dart';
import 'package:voucher/network/HttpClient.dart';
import 'package:voucher/provider/AuthProvider.dart';
import 'package:voucher/screens%20/voucher.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

class auth extends StatefulWidget {
  const auth({Key? key}) : super(key: key);

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  String? auth_nonce = "", auth_nonce_response = "";

  getdata2() {
    get2(ApiUrl.apiUrl + 'v1/rest/auth?usr=sysadmin&pwd=sysadmin',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Nonce': auth_nonce.toString(),
          'Auth-Nonce-Response': auth_nonce_response.toString(),
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        }).then((value) {});
  }

  getdata() {
    get(ApiUrl.apiUrl + 'v1/rest/auth', headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json, version=2',
      'Accept-Language':
          'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
    }).then((value) {
      getdata2();
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child:CircularProgressIndicator()),);
  }

  Future<dynamic> get(
    String url, {
    required Map<String, String> headers,
  }) async {
    var response = await http
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .then((value) {
      print("auth-nonce :" + value.headers["auth-nonce"].toString());
      setState(() {
        auth_nonce = value.headers["auth-nonce"];
        ApiUrl.auth_nonce=auth_nonce.toString();

        if (auth_nonce != null) {
          auth_nonce_response = ((double.parse(
                          (double.parse(auth_nonce!) / 13).toStringAsFixed(0)) %
                      99999) *
                  17)
              .toString();
          ApiUrl.auth_nonce_response=auth_nonce_response.toString();
              print("auth_nonce_response :" + auth_nonce_response.toString());
        } else {}
      });
    });
  }

  Future<dynamic> get2(
    String url, {
    required Map<String, String> headers,
  }) async {
    var response = await http
        .get(
      Uri.parse(url),
      headers: headers,
    )
        .then((value) {
      print("auth-session :" + value.headers["auth-session"].toString());

      if (value.headers["auth-session"] == null) {
        getdata();
      } else {

        ApiUrl.auth_session= value.headers["auth-session"].toString();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Voucher_screen()),
        );
      }
    });
  }
}
