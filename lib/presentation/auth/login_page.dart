import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd/application/provider/login_provider.dart';
import 'package:tdd/domain/model/login_error_model.dart';
import 'package:tdd/domain/model/token_model.dart';
import 'package:tdd/presentation/h.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        builder: (context, child) {
          if (context.watch<LoginProvider>().errorMessage.isNotEmpty) {
            return Center(
              child: Text(context.watch<LoginProvider>().errorMessage),
            );
          } else if (context.watch<LoginProvider>().loginErrorModel != null) {
            return Column(
              children: [
                Icon(Icons.sms_failed),
                Text(""),
                Text(context.watch<LoginErrorModel>().errorMessage.toString()),
              ],
            );
          } else if (context.watch<LoginProvider>().tokenModel != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserHPage(userModel: context.watch<TokenModel>())));
            return const SizedBox();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
