import 'package:gathrr/model/event_list_model/event_list_model.dart';
import 'package:gathrr/core/api_urls.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class OnBoardBlock {
  final onboardController = StreamController<List<EventListModel>>.broadcast();

  final titleController = StreamController<bool>.broadcast();
  final mobileController = StreamController<String>.broadcast();
  Stream<bool> get titleStream => titleController.stream;

  void updateTitle(bool newTitle) {
    titleController.add(newTitle);
  }

  void sendOtp({required String mobile}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/send-otp'),
        headers: headers,
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void verifyOtp({required String eventId}) async {
    print("eventId ::=> $eventId");
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(
        Uri.parse('$baseUrl/dummy/verify-otp'),
        headers: headers,
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void dispose() {
    onboardController.close();
  }
}
