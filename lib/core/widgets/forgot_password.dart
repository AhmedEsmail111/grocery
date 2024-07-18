import 'package:flutter/material.dart';
import 'package:grocery/views/forgot_password/forgot_password_view.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ForgotPasswordView(),
            ),
          );
        },
        child: Text(
          'Forgot Password?',
          style: const TextStyle().copyWith(
            color: Colors.lightBlue,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            decorationColor: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
