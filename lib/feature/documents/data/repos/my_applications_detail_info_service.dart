import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/documents/data/models/my_application_detail_info_page.dart';

class MyApplicationsDetailInfoService {
  var storage = FlutterSecureStorage();

  Future<MyApplicationDetailModel> getApplicationsDetailInfo(int appId) async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          "https://apikhizmat.ehukumat.tj/v1/application/view?id=$appId",
        ),

        headers: <String, String>{
          'Content-Type': "Application/json;Charset=utf-8",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var decode = myApplicationDetailModelFromJson(response.body);
        return decode!;
      } else {
        throw new Exception();
      }
    } catch (e) {
      throw new Exception();
    }
  }
}
