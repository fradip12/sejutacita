import 'dart:convert';

import 'package:citav2/core/models/user/user.model.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'https://api.github.com/search/';

class Git {
  static Future<UserResults> fetchUser(
      String keywords, int page, int limit) async {
    final response = await http.get(
        Uri.parse(BASE_URL + 'users?q=$keywords&page=$page&per_page=$limit'));

    if (response.statusCode == 200) {
      UserResults value = UserResults.fromJson(json.decode(response.body));
      return value;
    } else if (response.statusCode == 403) {
      UserResults value = UserResults.fromJson(json.decode(response.body));
      return value;
    } else {
      return throw Exception('Unable to get data');
    }
  }
}
