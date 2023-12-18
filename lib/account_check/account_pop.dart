import 'package:flutter/material.dart';

class AccountPop extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const AccountPop({required this.login, required this.press});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "IAlready have an Account" : " have an Account ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        SizedBox(
          width: 20,
        ),
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
