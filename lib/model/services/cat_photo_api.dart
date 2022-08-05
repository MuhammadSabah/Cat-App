import 'package:architecture_test/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

//Todo: Get your api key.
// const apiKey = 'Your api Key';

class CatPhotoApi {
  String endpoint = "api.thecatapi.com";
  Future<Either<String, String>> getRandomCatPhoto() async {
    try {
      final queryParameters = {
        "api_key": apiKey,
      };
      final uri = Uri.https(endpoint, "/v1/images/search", queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e.toString()));
    }
  }
}
