import 'package:dio/dio.dart';
import 'package:dorkar/config/api_urls.dart';

class SearchRepository {
  final Dio _dio = Dio();

  getSearchByKeyword(String keyword) async {
    final response =
        await _dio.get("${ApiUrl.getSearchProductsUrl}?query=$keyword&limit=6");
    return response;
  }

  getSearchByCategory(String keyword) async {
    final response = await _dio
        .get("${ApiUrl.getCategoryProductsUrl}?category=$keyword&limit=30");
    return response;
  }
}
