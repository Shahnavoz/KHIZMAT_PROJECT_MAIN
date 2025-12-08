
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:khizmat_new/feature/home/data/models/all_updated_date_model.dart';

class AllUpdatedDateService {
  var storage = FlutterSecureStorage();
  Future<AllUpdatedDateModel?> getAllInformation() async {
    try {
      var token = await storage.read(key: "token");
      var baseUrl =
          "https://apikhizmat.ehukumat.tj/v1/reference/documents/all?updated_date=0";
      var response = await http.get(
        Uri.parse(baseUrl),
        headers: <String, String>{
          "Accept":"application/json",
          "Authorization":"Bearer $token",
        },
      );
      // print(token);

      if (response.statusCode == 200) {
        // print(token);
        print(response.body);

        var data = allUpdatedDateModelFromJson(response.body);

        print(data.data.categories);
        print(data.data.documents);
        return data;
      } else {
        print("Errorr: ${response.statusCode}");
        print("Errorr: ${response.body}");
        throw Exception("Error else: ${response.body}, ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception("Error: ${e},");
      

    }
  }
}
