import 'package:flutter/material.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const AccountCheck({
    required this.login,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account" : "Already have an Account ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(width: 20,),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Create Account" : "Login",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
