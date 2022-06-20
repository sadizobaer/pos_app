import 'package:dorkar/config/strings.dart';
import 'package:provider/provider.dart';
import '../../controller/providers/home_provider.dart';
import 'navigation_service.dart';

class LanguageController {
  static bool isBangla() {
    return Provider.of<HomeProvider>(
                NavigationService.navigatorKey.currentContext!,
                listen: false)
            .isSwitched
        ? true
        : false;
  }

  static String category(){
    bool bangla = isBangla();
    return bangla ? BanglaString.category : EnglishString.category;
  }
  static String quickAdd(){
    bool bangla = isBangla();
    return bangla ? BanglaString.quickAdd : EnglishString.quickAdd;
  }
  static String total(){
    bool bangla = isBangla();
    return bangla ? BanglaString.total : EnglishString.total;
  }
  static String taka(){
    bool bangla = isBangla();
    return bangla ? BanglaString.taka : EnglishString.taka;
  }
  static String card(){
    bool bangla = isBangla();
    return bangla ? BanglaString.card : EnglishString.card;
  }
  static String bkash(){
    bool bangla = isBangla();
    return bangla ? BanglaString.bkash : EnglishString.bkash;
  }
  static String cash(){
    bool bangla = isBangla();
    return bangla ? BanglaString.cash : EnglishString.cash;
  }
  static String product(){
    bool bangla = isBangla();
    return bangla ? BanglaString.product : EnglishString.product;
  }
  static String name(){
    bool bangla = isBangla();
    return bangla ? BanglaString.name : EnglishString.name;
  }
  static String quantity(){
    bool bangla = isBangla();
    return bangla ? BanglaString.quantity : EnglishString.quantity;
  }
  static String price(){
    bool bangla = isBangla();
    return bangla ? BanglaString.price : EnglishString.price;
  }
  static String searchProduct(){
    bool bangla = isBangla();
    return bangla ? BanglaString.searchProduct : EnglishString.searchProduct;
  }
  static String addProductMsg(){
    bool bangla = isBangla();
    return bangla ? BanglaString.addProductMsg : EnglishString.addProductMsg;
  }
  static String noProductMsg(){
    bool bangla = isBangla();
    return bangla ? BanglaString.noProductMsg : EnglishString.noProductMsg;
  }
  static String loginText(){
    bool bangla = isBangla();
    return bangla ? BanglaString.loginText : EnglishString.loginText;
  }
  static String login(){
    bool bangla = isBangla();
    return bangla ? BanglaString.login : EnglishString.login;
  }
  static String forgetPassword(){
    bool bangla = isBangla();
    return bangla ? BanglaString.forgetPassword : EnglishString.forgetPassword;
  }
}
