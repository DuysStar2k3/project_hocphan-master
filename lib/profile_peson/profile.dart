import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_upload_image/Home/Home_Screen.dart';
import 'package:dev_upload_image/login_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePerson extends StatefulWidget {
  const ProfilePerson({super.key});

  @override
  State<ProfilePerson> createState() => _ProfilePersonState();
}

class _ProfilePersonState extends State<ProfilePerson> {
  String? name = '';
  String? email = '';
  String? image = '';
  String? phoneNo = '';
  File? imageXFile;
  String? inputUserName;

  Future _getDataFromDataBase() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["name"];
          email = snapshot.data()!["email"];
          image = snapshot.data()!["userImage"];
          phoneNo = snapshot.data()!["phoneNumber"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDataBase();
  }

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
        imageXFile = File(croppedFile.path);
      });
    }
  }

//upfirebase user
  void _updateUserName() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"name": inputUserName});
  }

//update user view
  void _displayInputUserName(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Cập nhật tên ở đây!"),
            content: TextField(
              onChanged: (value) {
                setState(
                  () {
                    inputUserName = value;
                  },
                );
              },
              decoration: const InputDecoration(hintText: "Text here!"),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    _updateUserName();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink,
                Colors.deepOrange.shade300,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.2, 0.9],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade400,
        title: const Center(
          child: Text(
            "Profile Screen",
            style: TextStyle(fontFamily: "Signatra", fontSize: 40),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink,
              Colors.deepOrange.shade300,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.4, 0.6],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showImageDiaLog();
              },
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                minRadius: 60,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: imageXFile == null
                      ? NetworkImage(image!)
                      : Image.file(imageXFile!).image,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: ${name!}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    //_updateUserName
                    _displayInputUserName(context);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            Text(
              "Email: ${email!}",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Phone Number: ${phoneNo!}",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text("LogOut"),
            )
          ],
        ),
      ),
    );
  }
}
