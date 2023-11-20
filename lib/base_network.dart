import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static final String baseUrl = "https://api.spaceflightnewsapi.net/v4/";

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final String fullUrl = baseUrl + endpoint;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    try {
      final response = await http.get(Uri.parse(fullUrl));
      debugPrint("BaseNetwork - response : ${response.body}");
      return _processResponse(response);
    } catch (e) {
      print("Error in HTTP request: $e");
      return {"error": true};
    }
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final String fullUrl = baseUrl + endpoint;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    try {
      final response = await http.post(
        Uri.parse(fullUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      debugPrint("BaseNetwork - response : ${response.body}");
      return _processResponse(response);
    } catch (e) {
      print("Error in HTTP request: $e");
      return {"error": true};
    }
  }

  static Future<Map<String, dynamic>> _processResponse(http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      try {
        final dynamic jsonBody = json.decode(body);
        if (jsonBody != null && jsonBody is Map<String, dynamic>) {
          return jsonBody;
        } else {
          print("Error parsing JSON or invalid JSON format");
          return {"error": true};
        }
      } catch (e) {
        print("Error parsing JSON: $e");
        return {"error": true};
      }
    } else {
      print("Empty response body");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}

/*class BaseNetwork {
  static final String baseUrl = "https://api.spaceflightnewsapi.net/v4/";
  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + partUrl; //users
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}*/