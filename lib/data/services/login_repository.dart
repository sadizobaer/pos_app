import 'package:dio/dio.dart';
import 'package:dorkar/config/api_urls.dart';

class LoginRepository{
  final Dio _dio = Dio();

  getLoginWithEmailAndPassword(String email, String password) async {
    final response =
    await _dio.post(ApiUrl.getLoginUrl, data: {
      "email": email,
      "password": password,
    });
    return response;
  }
}