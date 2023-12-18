import 'package:flutter/material.dart';

class TextFildeController extends StatelessWidget {
  final Widget child;

  const TextFildeController({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.redAccent,
            Colors.red,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(-2, -2),
            spreadRadius: 1,
            blurRadius: 4,
            color: Colors.redAccent,
          ),
          BoxShadow(
            offset: Offset(2, 2),
            spreadRadius: 1,
            blurRadius: 4,
            color: Colors.redAccent,
          ),
        ],
      ),
      child: child, // Add the child widget inside the Container
    );
  }
}
