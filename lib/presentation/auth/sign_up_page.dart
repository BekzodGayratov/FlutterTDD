import 'package:flutter/material.dart';
import 'package:tdd/domain/services/remote/auth_service.dart';
import 'package:tdd/presentation/home_page.dart';
import 'package:tdd/presentation/widgets/standart_padding.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: StandartPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: "first name"),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: "email"),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: "password"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await AuthService()
                .signUp(
                    firstName: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text)
                .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())));
          },
          label: const Text("Sign up")),
    );
  }
}
