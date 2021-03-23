import 'package:citav2/core/models/user/user_item_model.dart';

class UserResults {
  int total;
  List<UserItems> items;

  UserResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total_count'];

    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new UserItems.fromJson(v));
      });
    }
  }
}
