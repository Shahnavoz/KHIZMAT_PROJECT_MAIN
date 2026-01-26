import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/documents/data/models/my_documents_detail_model.dart';

class MyDocumentDetailService {
  var storage = FlutterSecureStorage();

  Future<MyDocumentDetailInfoModel> getDocumentDetailInfoById(int id) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse("https://apikhizmat.ehukumat.tj/v1/register/view?id=$id"),
        headers: <String, String>{
          'Content-Type': 'Application/json;Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var decoded = myDocumentDetailInfoModelFromJson(response.body);

        return decoded;
      } else {
        print("Response Body: ${response.body}");
        print("Statuscode: ${response.statusCode}");
        throw new Exception();
      }
    } catch (e) {
      print(e);
      throw new Exception();
    }
  }
}
