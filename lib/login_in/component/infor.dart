import 'package:dev_upload_image/Home/Home_Screen.dart';
import 'package:dev_upload_image/SignUp/sign_up.dart';
import 'package:dev_upload_image/account_check/account_check.dart';
import 'package:dev_upload_image/forget_pasword/forget_password.dart';
import 'package:dev_upload_image/Login_In/widget/button_login.dart';
import 'package:dev_upload_image/Login_In/widget/input_field.dart';
import 'package:dev_upload_image/login_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InFor extends StatelessWidget {
  InFor({super.key});
  final TextEditingController _emailTextController =
      TextEditingController(text: "");
  final TextEditingController _passWordTextController =
      TextEditingController(text: "");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: const AssetImage("images/logo1.png"),
              backgroundColor: Colors.orange.shade800,
              radius: 90,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            hinText: "Nhập Email...",
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            hinText: "Nhập Mật khẩu...",
            icon: Icons.key_off,
            obscureText: true,
            textEditingController: _passWordTextController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // Quên mật khẩu
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForGetPassWordScreen()));
                },
                child: const Text(
                  "Quên Mật khẩu?",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
          ButtonLogin(
            text: "Đăng Nhập",
            color1: Colors.red,
            color2: Colors.redAccent,
            press: () async {
              try {
                await _auth.signInWithEmailAndPassword(
                  email: _emailTextController.text.trim().toLowerCase(),
                  password: _passWordTextController.text.trim().toLowerCase(),
                );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              } catch (e) {
                Fluttertoast.showToast(msg: "Người dùng không tồn tại");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
          ),
          AccountCheck(
              login: true,
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              })
        ],
      ),
    );
  }
}
