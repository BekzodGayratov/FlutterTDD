import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tdd/domain/model/login_error_model.dart';
import 'package:tdd/domain/model/token_model.dart';

class AuthService {
  Future<void> signUp(
      {required String firstName,
      required String email,
      required String password}) async {
    try {
      Response response = await Dio().post('http://localhost:3000/signUp',
          data: {
            "first_name": firstName,
            "email": email,
            "password": password
          });
      if (response.statusCode == 201) {
        debugPrint(response.data['message']);
        debugPrint(response.data['token']);
      }
    } on DioException catch (e) {
      debugPrint(e.error.toString());
      rethrow;
    }
  }

  Future<Either<dynamic, TokenModel>> login(
      String userName, String password) async {
    try {
      Response response = await Dio(BaseOptions(
        sendTimeout: const Duration(seconds: 55),
        receiveTimeout: const Duration(seconds: 55),
        connectTimeout: const Duration(seconds: 55),
        validateStatus: (status) {
          if (status! >= 100 && status <= 599) {
            return true;
          } else {
            return false;
          }
        },
      )).post("https://", data: {"username": "0012312", "password": "0987654"});

      if (response.statusCode == 200) {
        return right(TokenModel());
      } else if (response.statusCode == 401) {
        return left(LoginErrorModel("Parol yoki user name xato", 401));
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return left(e.error);
    }
  }

  Future<void> getUserMe() async {
    try {
      var tokem = "askdhakshdkjahsdklakjhlsd";
      Response response = await Dio().get("htts/me",
          options: Options(headers: {"authorization": "Bearer $tokem"}));
      
    } on DioException catch (e) {
  
    }
  }
}
