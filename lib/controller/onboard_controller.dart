import 'package:gathrr/model/event_list_model/event_list_model.dart';
import 'package:gathrr/utils/api_urls.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class PostBloc {
  final _postController = StreamController<List<EventListModel>>.broadcast();
  Stream<List<EventListModel>> get posts => _postController.stream;

  void sendOtp() async {
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
    _postController.close();
  }
}
