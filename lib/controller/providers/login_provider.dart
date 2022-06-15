import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{
  bool _isAuthenticating = false;

  get getAuthenticating => _isAuthenticating;

  setAuthenticating(bool value){
    _isAuthenticating = value;
    notifyListeners();
  }

}