import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeadText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Text(
              "Photo-Share",
              style: TextStyle(
                fontSize: 75,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Signatra"
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white60,
                fontWeight: FontWeight.bold,
                fontFamily: "Bebas"
              ),
            ),
          )
        ],
      ),
    );
  }
}
