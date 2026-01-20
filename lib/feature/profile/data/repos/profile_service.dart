import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  var storage = FlutterSecureStorage();
  Future<void> logOut() async {
    var token = storage.read(key: "token");
    var response = await http.post(
      Uri.parse("https://apikhizmat.ehukumat.tj/v1/oauth/logout"),

      headers: <String, String>{
        "Content-Type": "Application/json;Charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print("Logout successfully!");
    }
    else{
      print("some error!");
    }
  }
}
