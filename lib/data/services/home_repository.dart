import 'package:dio/dio.dart';
import 'package:dorkar/config/api_urls.dart';

class HomeRepository {
  final Dio _dio = Dio();

  getAllCategories() async{
    final response = await _dio.get(ApiUrl.getAllCategoriesUrl);
    return response;
  }
  getAllProducts() async{
    final response = await _dio.get(ApiUrl.getAllProductsUrl);
    return response;
  }
}
