import 'package:dev_upload_image/Chi_tiet_Image/Detaill_photo.dart';
import 'package:flutter/material.dart';

Widget gridViewWideget(BuildContext context,String docId, String image, String userImage,
      String name, DateTime date, String userId, int downloads) {
    return GridView.count(
      crossAxisCount: 1, // Số lượng cột là 1 để có một cột
      crossAxisSpacing: 1,
      mainAxisSpacing: 1, // Thêm khoảng cách theo chiều dọc
      padding: const EdgeInsets.all(6),
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPhoto(
                    image: image,
                    userImage: userImage,
                    name: name,
                    userId: userId,
                    docId: docId,
                    date: date,
                    downloads: downloads,
                  ),
                ),
              );
            },
            child: Center(
              child: Hero(
                tag: docId,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }