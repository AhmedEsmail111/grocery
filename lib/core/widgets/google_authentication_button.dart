import 'package:flutter/material.dart';
import 'package:grocery/providers/authentication/authenticaion_provider.dart';
import 'package:provider/provider.dart';

class GoogleAuthenticationButton extends StatelessWidget {
  const GoogleAuthenticationButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        authenticationProvider.signInWithGoogle(context);
      },
      child: Material(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                color: Colors.white,
                child: Image.asset(
                  'assets/images/google.png',
                  width: width * 0.10,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: const TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
