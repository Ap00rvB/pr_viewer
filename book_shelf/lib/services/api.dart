import 'package:http/http.dart';

class ApiService {
  final String url;

  ApiService({required this.url});

  Future<Response> request(String url) async {
    Response res = await get(Uri.parse(url));
    return res;
  }
}
