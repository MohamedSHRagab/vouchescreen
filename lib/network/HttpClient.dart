import 'package:http/http.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClient {
  bool _loggingEnabled = true;
  Future<dynamic> post(String url,
      {required Map<String, String> headers,  String? body}) async {
    Response response = await http.post(Uri.parse(url), headers: headers, body: body);
    log(response);
    if (response.statusCode <= 500) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Error in status code');
      return Exception();
    }
  }

  Future<dynamic> delete(String url, {required Map<String, String> headers}) async {
    Response response = await http.delete(Uri.parse(url), headers: headers);
    log(response);
    if (response.statusCode <= 500) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Error in status code');
      return Exception();
    }
  }

  Future<dynamic> get(
      String url, {
        required Map<String, String> headers,
      }) async {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode <= 500) {
      var jsonResponse = convert.jsonDecode(response.body);
     // print(jsonResponse);
      return jsonResponse;
    } else {
      print('Error in status code');
      return Exception();
    }
  }

  Future<dynamic> put(String url,
      {required Map<String, String> headers,required String body}) async {
    Response response = await http.put(Uri.parse(url), headers: headers, body: body);
    log(response);
    if (response.statusCode <= 500) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Error in status code');
      return Exception();
    }
  }

  log(Response response) {
    if (_loggingEnabled) {
      print(response.body);
    }
  }
}