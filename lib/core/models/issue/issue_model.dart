import 'package:citav2/core/models/issue/issue_item_model.dart';

class IssueResults {
  int total;
  List<IssueItem> items;

  IssueResults.fromJson(Map<dynamic, dynamic> json) {
    total = json['total_count'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new IssueItem.fromJson(v));
      });
    }
  }
}
