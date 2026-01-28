import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/documents/data/models/my_documents_model.dart';

class MyDocumentsService {
  var storage = FlutterSecureStorage();

  Future<MyDocumentsModel> getMyDocuments() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse(
          'https://apikhizmat.ehukumat.tj/v1/register/list?page=4&size=10&sort=id,desc',
        ),

        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decode = myDocumentModelFromJson(response.body);
        return decode;
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
