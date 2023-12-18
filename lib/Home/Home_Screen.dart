import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_upload_image/Home/widget/grid_view.dart';
import 'package:dev_upload_image/Home/widget/list_view.dart';
import 'package:dev_upload_image/login_in/login_screen.dart';
import 'package:dev_upload_image/profile_peson/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String changTitle = "Grid View";
  bool checkView = false;
  File? imageFile;
  String? imageUrl;
  String? myImage;
  String? myname;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    _cropImage(context, pickedFile?.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(context, pickedFile?.path);
    Navigator.pop(context);
  }

  void _cropImage(BuildContext context, String? filePath) async {
    if (filePath != null) {
      CroppedFile? croppedFile = await ImageCropper()
          .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
      if (croppedFile != null) {
        setState(() {
          imageFile = File(croppedFile.path);
        });
      }
    }
  }

  void _uploadImage() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please select an Image");
    }
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("userImage")
          .child('${DateTime.now()}jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("wallpaper")
          .doc(DateTime.now().toString())
          .set({
        "id": _auth.currentUser!.uid,
        "email": _auth.currentUser!.email,
        "userImage": myImage,
        "name": myname,
        "image": imageUrl,
        "downloads": 0,
        "createAt": DateTime.now(),
      });
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void read_userInfor() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser.uid)
          .get()
          .then<dynamic>((DocumentSnapshot snapshot) async {
        myImage = snapshot.get("userImage");
        myname = snapshot.get("name");
      });
    } else {
      // Xử lý trường hợp người dùng chưa đăng nhập hoặc đã đăng xuất
      // Ví dụ: Hiển thị một thông báo hoặc thực hiện các hành động khác
    }
  }

  @override
  void initState() {
    super.initState();
    read_userInfor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "1",
                backgroundColor: Colors.deepOrange.shade500,
                onPressed: () {
                  _showImageDiaLog();
                },
                child: const Icon(Icons.camera_enhance),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.purple.shade500,
                onPressed: () {
                  _uploadImage();
                },
                child: const Icon(Icons.cloud_upload),
              ),
            )
          ],
        ),
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              setState(() {
                changTitle = "Grid View";
                checkView = true;
                // Thực hiện cập nhật dữ liệu mô hình cho chế độ xem Grid
                // Cập nhật danh sách hoặc grid view tại đây
              });
            },
            onDoubleTap: () {
              setState(() {
                changTitle = "List View";
                checkView = false;
                // Thực hiện cập nhật dữ liệu mô hình cho chế độ xem List
                // Cập nhật danh sách hoặc grid view tại đây
              });
            },
            child: Text(changTitle),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePerson()),
              ),
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("wallpaper")
              .orderBy("createAt",
                  descending:
                      true) // Assuming there is a field named 'createdAt'
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                if (checkView == false) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listViewWideget(
                        context,
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return gridViewWideget(
                        context,
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                }
              } else {
                return const Center(
                  child:
                      Text("There is no tasks", style: TextStyle(fontSize: 20)),
                );
              }
            }
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
