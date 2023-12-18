
import 'package:dev_upload_image/Login_In/widget/textFiledController.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hinText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textEditingController;

  const InputField({
    required this.hinText,
    required this.icon,
    required this.obscureText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFildeController(
      child: TextField(
        cursorColor: Colors.white,
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinText,
          helperStyle: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
