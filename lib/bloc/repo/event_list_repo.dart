import 'dart:convert';

import 'dart:developer';

import 'package:gathrr/core/api_urls.dart';
import 'package:gathrr/model/event_list_model/event_list_model.dart';
import 'package:http/http.dart' as http;

class EventListRepo {
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
}
