import 'package:dio/dio.dart';
import 'package:dorkar/config/api_urls.dart';

class HomeRepository {
  final Dio _dio = Dio();

  Future<Response> getAllCategories() async{
    Response response;
    response = await _dio.get(ApiUrl.getAllCategoriesUrl);
    return response;
  }
}
