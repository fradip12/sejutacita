import 'dart:convert';

import 'package:citav2/core/models/login/login_model.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://172.104.44.22';

class Git {
  static Future<LoginResult> login({String user, String pass}) async {
    final response = await http
        .get(Uri.parse(BASE_URL + '/api/method/login?usr=$user&pwd=$pass'));

    if (response.statusCode == 200) {
      LoginResult value = LoginResult.fromJson(json.decode(response.body));
      return value;
    }
    return throw Exception('Unable to get data');
  }
}
