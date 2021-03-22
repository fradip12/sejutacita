import 'package:citav2/core/models/user/user_item_model.dart';

class UserResults {
  String total;
  List<UserItems> items;

  UserResults.fromJson(Map<String, dynamic> json) {
    total = json['total_count'].toString();
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new UserItems.fromJson(v));
      });
    }
  }
}
