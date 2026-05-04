import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/documents/data/models/my_applications_model.dart';

class MyApplicationService {
  var storage = FlutterSecureStorage();

  Future<MyApplicationsModel> getApplications() async {
    try {
      var token = await storage.read(key: 'token');

      var response = await http.get(
        Uri.parse(
          "https://api.ekhizmat.tj/v1/application/list?page=0&size=1000",
        ),
        headers: <String, String>{
          "Content-Type": "Application/json",
          "Accept": 'application/json',
          "Authorization": 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = myApplicationsModelFromJson(response.body);
        print(decoded);
        return decoded;
        
      } else {
        print("Response Statuscode: ${response.statusCode}");
        print("Response Body: ${response.body}");
        print("Response Message: ${response.reasonPhrase}");
        throw new Exception("Some Error: $response.reasonPhrase");
      }
    } catch (e, st) {
      print("Error Message: $e");
      print("Error StackTrace: $st");
      throw new Exception("Some Error: $e");
    }
  }
}
