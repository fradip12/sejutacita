
class UserItems {
  String login;
  String id;
  String nodeId;
  String avatar;
  String url;
  String type;
  String score;

  UserItems.fromJson(Map<String,dynamic> json){
    login = json['login'];
    id = json['id'].toString();
    nodeId = json['node_id'];
    avatar = json['avatar_url'];
    url = json['url'];
    type = json['type'];
    score = json['score'].toString();
  }

}