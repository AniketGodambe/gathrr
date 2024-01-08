import 'dart:convert';

import 'package:gathrr/core/api_urls.dart';
import 'package:http/http.dart' as http;

class AuthReposotory {
  Future sendOtp({required String phone}) async {
    print("Calling Data :::=> $phone");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      Map<dynamic, dynamic> payload = {"mobile": phone};

      final response = await http.post(Uri.parse('$baseUrl/dummy/send-otp'),
          headers: headers, body: payload);
      var jsonMap = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonMap;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  login() {}
}
