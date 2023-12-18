import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_upload_image/SignUp/sign_up.dart';
import 'package:dev_upload_image/account_check/account_check.dart';
import 'package:dev_upload_image/login_in/login_screen.dart';
import 'package:dev_upload_image/login_in/widget/button_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../login_in/widget/input_field.dart';

class InFor extends StatefulWidget {
  const InFor({super.key});

  @override
  State<InFor> createState() => _InForState();
}

class _InForState extends State<InFor> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;
  String? imageUrl;

  final TextEditingController _emailTextController =
      TextEditingController(text: "");

  final TextEditingController _passWordTextController =
      TextEditingController(text: "");

  final TextEditingController _fullNameController =
      TextEditingController(text: "");

  final TextEditingController _phoneNumberController =
      TextEditingController(text: "");

  void _showImageDiaLog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Plaese choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () =>
                    //get fromcamera
                    _getFromCamera(),
                child: const Row(children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.camera,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(color: Colors.red),
                  ),
                ]),
              ),
              InkWell(
                onTap: () => _getFromGallery(),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.image,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context); // Remove context parameter
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context); // Remove context parameter
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showImageDiaLog();
              },
              child: CircleAvatar(
                backgroundImage: imageFile == null
                    ? const AssetImage("images/avatar.png")
                    : Image.file(imageFile!).image,
                radius: 50, // Đặt bán kính của CircleAvatar tại đây
              ),
            ),
            InputField(
              hinText: "Nhập họ tên...",
              icon: Icons.people_alt_rounded,
              obscureText: false,
              textEditingController: _fullNameController,
            ),
            InputField(
              hinText: "Nhập Email...",
              icon: Icons.email_rounded,
              obscureText: false,
              textEditingController: _emailTextController,
            ),
            InputField(
              hinText: "Nhập Password...",
              icon: Icons.key_off,
              obscureText: true,
              textEditingController: _passWordTextController,
            ),
            InputField(
              hinText: "Nhập số điện thoại...",
              icon: Icons.phone_android,
              obscureText: false,
              textEditingController: _phoneNumberController,
            ),
            ButtonLogin(
              text: "Create",
              color1: Colors.red,
              color2: Colors.redAccent,
              press: () async {
                if (imageFile == null) {
                  Fluttertoast.showToast(msg: "Vui lòng cập nhật ảnh trước");
                  return;
                }

                try {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child("userImage")
                      .child('${DateTime.now()}jpg');
                  await ref.putFile(imageFile!);
                  imageUrl = await ref.getDownloadURL();

                  await _auth.createUserWithEmailAndPassword(
                    email: _emailTextController.text.trim(),
                    password: _passWordTextController.text.trim(),
                  );

                  final User? user = _auth.currentUser;
                  final uid = user!.uid;

                  FirebaseFirestore.instance.collection("user").doc(uid).set({
                    "id": uid,
                    "userImage": imageUrl,
                    "name": _fullNameController.text,
                    "email": _emailTextController.text,
                    "phoneNumber": _phoneNumberController.text,
                    "creatAt": Timestamp.now(),
                  });

                  Fluttertoast.showToast(msg: "Đăng ký thành công!");
                  // Clear all input fields
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                } catch (e) {
                  Fluttertoast.showToast(msg: "Người dùng đã tồn tại");
                  // Clear all input fields
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                }
              },
            ),
            const SizedBox(height: 10),
            AccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
