import '../user/user_item_model.dart';

class IssueItem {
  String url;
  String id;
  String nodeId;
  String number;
  String title;
  UserItems user;
  String status;
  String comment;
  String createdAt;
  String body;

  IssueItem.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'].toString();
    nodeId = json['node_id'];
    number = json['number'].toString();
    title = json['title'];
    if (json['user'] != null) {
      user = new UserItems.fromJson(json['user']);
    }
    status = json['state'];
    comment = json['comments'].toString();
    createdAt = json['created_at'];
    body = json['body'];
  }
}
