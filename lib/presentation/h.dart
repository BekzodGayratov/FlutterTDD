import 'package:flutter/material.dart';
import 'package:tdd/domain/model/token_model.dart';

class UserHPage extends StatelessWidget {
  final TokenModel userModel;
  const UserHPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userModel.accessToken.toString())),
    );
  }
}
