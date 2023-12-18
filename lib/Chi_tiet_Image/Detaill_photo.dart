import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_upload_image/Home/Home_Screen.dart';
import 'package:dev_upload_image/login_in/widget/button_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';

class DetailsPhoto extends StatefulWidget {
  String? image;
  String? userImage;
  String? name;
  String? docId;
  String? userId;
  int? downloads;
  DateTime? date;

  DetailsPhoto({
    super.key,
    required this.image,
    required this.userImage,
    required this.name,
    required this.docId,
    required this.userId,
    required this.downloads,
    required this.date,
  });

  @override
  State<DetailsPhoto> createState() => _DetailsPhotoState();
}

class _DetailsPhotoState extends State<DetailsPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Hero(
                tag: widget.docId ??
                    'defaultTag', // Tag phải trùng với tag ở widget trước
                child: Container(
                  // ... (Nội dung chi tiết ảnh)
                  child: Image.network(
                    widget.image!,
                    height: 300, // Set the height of the image as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.userImage!),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Uploads By: ${widget.name!}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat("dd/MM/yyyy - hh:mm a ")
                    .format(widget.date!)
                    .toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.download,
                    size: 28,
                  ),
                  Text(
                    " ${widget.downloads!}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ButtonLogin(
                  text: "Download",
                  color1: Colors.green,
                  color2: Colors.greenAccent,
                  press: () async {
                    try {
                      var imageId =
                          await ImageDownloader.downloadImage(widget.image!);

                      if (imageId != null) {
                        Fluttertoast.showToast(msg: "Tải ảnh thành công");
                        int newDownloads = widget.downloads! + 1;

                        await FirebaseFirestore.instance
                            .collection("wallpaper")
                            .doc(widget.docId)
                            .update({"downloads": newDownloads});

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Tải ảnh không thành công");
                      }
                    } catch (error) {
                      print("Lỗi khi tải ảnh: $error");
                      Fluttertoast.showToast(msg: "Đã xảy ra lỗi khi tải ảnh");
                    }
                  },
                ),
              ),
              FirebaseAuth.instance.currentUser!.uid == widget.userId
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ButtonLogin(
                        text: "Delete",
                        color1: Colors.green,
                        color2: Colors.greenAccent,
                        press: () async {
                          try {
                            // Hiển thị cảnh báo hoặc xác nhận xóa ở đây nếu cần

                            // Thực hiện xóa
                            await FirebaseFirestore.instance
                                .collection("wallpaper")
                                .doc(widget.docId)
                                .delete();

                            // Đóng cửa số xem chi tiết
                            Navigator.pop(context);
                          } catch (error) {
                            // Xử lý lỗi khi xóa
                            print("Error deleting document: $error");
                            // Hiển thị thông báo lỗi hoặc thực hiện các hành động khác
                          }
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ButtonLogin(
                  text: "Go Back",
                  color1: Colors.green,
                  color2: Colors.greenAccent,
                  press: () async {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),

          // Additional content in the ListView can be added here
        ],
      ),
    );
  }
}
