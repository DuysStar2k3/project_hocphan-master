import 'package:dev_upload_image/Login_In/component/heading.dart';
import 'package:dev_upload_image/Login_In/component/infor.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.deepOrange.shade300,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.2, 0.9],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeadText(),
                  InFor(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
