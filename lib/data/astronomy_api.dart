import 'dart:convert';
import 'package:http/http.dart' as http;
import 'astronomy_response.dart';
import '../utils/constants.dart';

class AstronomyApi {
  Future<AstronomyResponse> getAstronomyPicture({DateTime? date}) async {
    var formattedDate = date != null ? date.toIso8601String().split("T")[0] : DateTime.now().toIso8601String().split("T")[0];
    var queryString = "api_key=$API_KEY&date=$formattedDate";
    var url = Uri.parse("$BASE_URL$queryString");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return AstronomyResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Astronomy Picture of the Day: ${response.reasonPhrase}');
    }
  }
}
