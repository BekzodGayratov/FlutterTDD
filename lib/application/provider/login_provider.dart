import 'package:flutter/material.dart';
import 'package:tdd/domain/model/login_error_model.dart';
import 'package:tdd/domain/model/token_model.dart';
import 'package:tdd/domain/services/remote/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String errorMessage = "";
  LoginErrorModel? loginErrorModel;
  TokenModel? tokenModel;

  Future<void> login(String userName, String password) async {
    isLoading = true;
    var res = await _authService.login(userName, password);
    res.fold((l) {
      if (l is LoginErrorModel) {
        isLoading = false;
        loginErrorModel = l;
        notifyListeners();
      } else {
        isLoading = false;
        errorMessage = l;
        notifyListeners();
      }
    }, (r) {
      
      isLoading = false;
      tokenModel = r;
      notifyListeners();
    });
  }
}
