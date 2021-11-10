class LoginResult {
  String message;
  String routes;
  String fullName;

  LoginResult.fromJson(Map<dynamic, dynamic> json) {
    message = json["message"];
    routes = json["home_page"];
    fullName = json["full_name"];
  }
}
