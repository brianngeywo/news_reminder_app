import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  String baseUrl = 'https://hindenburgresearch.com/';

  Future<String?> get() async {
    Response res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
