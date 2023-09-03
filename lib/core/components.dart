// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

Widget mainCircleAvatar(IconData? icon) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: CircleAvatar(
      backgroundColor: Colors.grey.withOpacity(0.2),
      radius: 20.0,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    ),
  );
}

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButton({
    Key? key,
    required this.isLiked,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String user;
  final String text;
  final String time;
  const Comment(
      {super.key, required this.user, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // comment
        Text(text),
        const SizedBox(
          height: 5,
        ),
        // user, time
        Row(
          children: [
            Text(
              user,
              style: const TextStyle(color: Colors.grey),
            ),
            const Text(" . "),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ]),
    );
  }
}

class CommentButton extends StatelessWidget {
  final void Function()? onTap;
  const CommentButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}

Future<bool> checkNetwork() async {
  bool isConnected = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    isConnected = false;
  }
  return isConnected;
}
