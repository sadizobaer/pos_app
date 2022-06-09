class ApiUrl{
  static const String baseApiUrl = 'https://api.dorkar.io/api/en';

  static String getAllCategoriesUrl = '$baseApiUrl/product/categories';

  static String getCategoryProductsUrl = '$baseApiUrl/product/products';

  static String getSearchProductsUrl = '$baseApiUrl/search';
}