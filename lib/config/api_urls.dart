class ApiUrl{
  static const String baseUrl = 'https://api.dorkar.io';

  static const String baseApiUrl = '$baseUrl/api/en';

  static String getAllCategoriesUrl = '$baseApiUrl/product/categories';

  static String getCategoryProductsUrl = '$baseApiUrl/product/products';

  static String getSearchProductsUrl = '$baseApiUrl/search';

  static String getLoginUrl = '$baseUrl/admin/auth/login';
}