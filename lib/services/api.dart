import 'dart:convert';

import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/services/impl/app_error_response.dart';
import 'package:upstreet_flutter_code_challenge/services/impl/app_response.dart';

import 'package:http/http.dart' as http;

const API_ALBUMS_PHOTOS =
    'https://jsonplaceholder.typicode.com/albums/1/photos';

// TODO:
// Create a function for fetching data from `API_ALBUMS_PHOTOS`
Future<AppResponse<List<Photos>>> getPhotos() async {
  http.Response result = await http.get(
    API_ALBUMS_PHOTOS,
  );
  try {
    if (result.statusCode == 200) {
      var body = json.decode(result.body);
      List<Photos> photos = [];
      print(body);
      if (body != null && body.length > 0) {
        for (int i = 0; i < body.length; i++) {
          photos.add(Photos.fromJson(body[i]));
        }
      }
      return AppResponse(data: photos);
    } else {
      return AppResponse(
          error: ErrorResponse(result.body, '', result.statusCode));
    }
  } catch (e) {
    return AppResponse(
        error: ErrorResponse(e.toString(), '', result.statusCode));
  }
}
