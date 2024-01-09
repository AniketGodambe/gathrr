import 'dart:convert';

import 'dart:developer';

import 'package:gathrr/core/api_urls.dart';
import 'package:gathrr/model/event_by_id_model.dart';
import 'package:gathrr/model/event_list_model/event_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventIdRepo {
  static Future<List<EventListModel>> getEventList() async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/event-list'),
        headers: headers,
      );
      var jsonMap = json.decode(response.body);
      List<EventListModel> data = (jsonMap['data'] as List)
          .map((i) => EventListModel.fromJson(i))
          .toList();
      return data;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<EventByIdModel> getEventById({required String eventId}) async {
    print("eventId ::=> $eventId");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/event-details/$eventId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body);
        // final data = (jsonMap['data'] as List)
        //     .map((i) => EventListModel.fromJson(i))
        //     .toList();
        final data = EventByIdModel.fromJson(jsonMap['data']);

        return data;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  String formatDate({
    DateTime? date,
    required String format,
  }) {
    DateTime now = date ?? DateTime.now();
    return DateFormat(format).format(now);
  }

  String formatDateWith5h30m({
    DateTime? date,
    required String format,
  }) {
    DateTime now = date == null
        ? DateTime.now()
        : date.add(const Duration(hours: 5, minutes: 30));
    return DateFormat(format).format(now);
  }

  static Future launchUrlFN(url) async {
    try {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print(e);
    }
  }
}
