// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gathrr/core/api_urls.dart';
import 'package:gathrr/core/error_dialog.dart';
import 'package:gathrr/presentation/events/event_list_screen.dart';
import 'package:gathrr/presentation/onboard/otp_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static Future<bool> sendOtp(
      {required String phone, required bool isnavigation}) async {
    try {
      Map<String, dynamic> payload = {"phone": phone};

      Map<String, String> headers = {"Content-Type": "application/json"};
      var url = 'https://gathrr.radarsofttech.in:5050/dummy/send-otp';

      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(payload));
      var jsonMap = json.decode(response.body);

      if (jsonMap['status'] == true) {
        if (isnavigation == true) {
          Get.to(() => OtpScreen(phone: phone));
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('sendOtp ::=> Error: $e');
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return const ErrorPopup(
            errorMsg: "Something went wrong!",
            errorTitle: 'Oops',
            btnLabel: "Retry",
          );
        },
      );
      return false;
    }
  }

  static Future<bool> verifyOtp(
      {required String otp, required String phone}) async {
    try {
      Map<dynamic, dynamic> payload = {"phone": phone, "otp": otp};
      Map<String, String> headers = {"Content-Type": "application/json"};
      final String url = '$baseUrl/dummy/verify-otp';
      final response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(payload));
      var jsonMap = json.decode(response.body);

      if (jsonMap['status'] == true) {
        Get.offAll(() => const EventListPage());
        final GetStorage storage = GetStorage();
        storage.write('appState', "login");

        return true;
      } else {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return const ErrorPopup(
              errorMsg: "Incorect otp!",
              errorTitle: 'Required',
              btnLabel: "Okay",
            );
          },
        );
        return false;
      }
    } catch (e) {
      log('verifyOtp ::=> Error: $e');
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return const ErrorPopup(
            errorMsg: "Something went wrong!",
            errorTitle: 'Oops',
            btnLabel: "Retry",
          );
        },
      );
      return false;
    }
  }
}
