import 'dart:convert';
import 'package:http/http.dart' as http;

class FormService {
  static Future<String> submitForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.byteplex.info/api/test/contact/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'message': message,
        }),
      );

      if (response.statusCode == 201) {
        return 'Success! Form submitted successfully.';
      } else {
        return 'Error: Something went wrong. Status code: ${response.statusCode}';
      }
    } catch (error) {
      return 'Error: $error';
    }
  }
}
