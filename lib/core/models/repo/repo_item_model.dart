import 'package:citav2/core/models/user/user_item_model.dart';

class RepoItemModel {
  String id;
  String name;
  String fullName;
  bool private;
  UserItems owner;
  String description;
  String lastUpdate;
  String language;
  LicenseModel license;
  String seenCount;

  RepoItemModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    fullName = json['full_name'];
    private = json['private'];
    description = json['description'];
    lastUpdate = json['updated_at'];
    language = json['language'];
    seenCount = json['watchers'].toString();

    if (json['owner'] != null) {
      owner = new UserItems.fromJson(json['owner']);
    }
    if (json['license'] != null) {
      license = new LicenseModel.fromJson(json['license']);
    }
  }
}

class LicenseModel {
  String key;
  String name;

  LicenseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
  }
}
