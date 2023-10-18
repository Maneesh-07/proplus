import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClass {
  Future<void> login(String email, String password) async {
    if (!_validateEmail(email)) {
      print('Invalid email, please try again');
      return;
    }

    const String url = 'https://spotit.cloud/interview/api/login';

    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Login successful!');
      print('Response data: ${response.body}');
    } else {
      final body = jsonDecode(response.body);

      if (body['message'] == 'Login Failed') {
        final errors = body['errors'];

        if (errors != null && errors['email'] != null) {
          final emailErrors = errors['email'];
          print(emailErrors[0]);
        } else {
          print('Login failed for unknown reason');
        }
      }
    }
  }

// Simple email validation
  bool _validateEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

 
}
