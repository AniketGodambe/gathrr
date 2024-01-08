import 'dart:developer';

import 'package:gathrr/model/event_list_model/event_list_model.dart';
import 'package:gathrr/core/api_urls.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PostBloc {
  final _postController = StreamController<List<EventListModel>>.broadcast();

  Stream<List<EventListModel>> get posts => _postController.stream;

  fetchEventList() async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/event-list'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body);
        final data = (jsonMap['data'] as List)
            .map((i) => EventListModel.fromJson(i))
            .toList();
        _postController.sink.add(data);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  void getEventById({required String eventId}) async {
    print("eventId ::=> $eventId");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/event-details/64eef1ec933313ae25df7b9d'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body);
        final data = (jsonMap['data'] as List)
            .map((i) => EventListModel.fromJson(i))
            .toList();
        _postController.sink.add(data);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void dispose() {
    _postController.close();
  }
}
