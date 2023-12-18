import 'package:dev_upload_image/Chi_tiet_Image/Detaill_photo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget listViewWideget(BuildContext context,String docId, String image, String userImage,
      String name, DateTime date, String userId, int downloads) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 16,
        shadowColor: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userImage),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: const Text(
                              " đã thêm ảnh mới.",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(calculateTimeAgo(date),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
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
                child: Hero(
                  tag: docId, // Tag phải là duy nhất cho mỗi ảnh
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Like, Comment, Download buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Add like functionality here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Add comment functionality here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () {
                    // Add download functionality here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //date time
  String calculateTimeAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} giờ trước';
    } else {
      return DateFormat("dd-MM-yyyy - HH:mm").format(date);
    }
  }