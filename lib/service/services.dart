import 'package:http/http.dart' as http;

class Services {
  static var client = http.Client();
  static var baseURL = 'https://api.themoviedb.org';
  static var api_key = 'api_key=26763d7bf2e94098192e629eb975dab0&page';

  static Future<dynamic> fetchItem(int page) async {
    var response = await client.get(
      Uri.parse('$baseURL/3/discover/movie?$api_key&page=$page'),
    );
    print('$baseURL/3/discover/movie?$api_key&page=$page');
    return response;
  }
}
