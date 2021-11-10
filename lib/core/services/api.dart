import 'dart:convert';

import 'package:citav2/core/models/item/item_model.dart';
import 'package:citav2/core/models/login/login_model.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://172.104.44.22';

class Git {
  static Future<LoginResult> login({String user, String pass}) async {
    final response = await http
        .get(Uri.parse(BASE_URL + '/api/method/login?usr=$user&pwd=$pass'));

    LoginResult value = LoginResult.fromJson(json.decode(response.body));
    return value;
  }

  static Future<List<ItemResult>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    List<ItemResult> data = [];
    json.decode(response.body).forEach((v) {
      ItemResult _tmp = ItemResult.fromJson(v);
      data.add(_tmp);
    });
    return data;
  }
}
