import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color1;
  final Color color2;

  const ButtonLogin({
    required this.text,
    required this.press,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerLeft,
                colors: [
                  Colors.redAccent,
                  Colors.red,
                ]),
            boxShadow: [
              BoxShadow(
                offset: Offset(-3, -3),
                spreadRadius: 1,
                blurRadius: 4,
                color: Colors.redAccent,
              ),
              BoxShadow(
                offset: Offset(-5, -5),
                spreadRadius: 1,
                blurRadius: 4,
                color: Colors.redAccent,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
