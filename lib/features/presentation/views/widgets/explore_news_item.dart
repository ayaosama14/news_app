// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/helper_methods.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:news_app/core/components.dart';
import 'package:news_app/core/repo/hive_helper.dart';
import 'package:news_app/features/presentation/views/other_screens/item_detail_screen.dart';

import '../../../../core/models/news_model/hive_bookMark_model.dart';

class ExploreNewsItem extends StatefulWidget {
  const ExploreNewsItem({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.source,
    required this.date,
    required this.content,
    required this.postId,
    required this.likes,
    required this.time,
  }) : super(key: key);

  final String imageUrl;
  final String category;
  final String title;
  final String source;
  final String date;
  final String content;
  final String postId;
  final String time;
  final List<String> likes;

  @override
  State<ExploreNewsItem> createState() => _ExploreNewsItemState();
}

class _ExploreNewsItemState extends State<ExploreNewsItem> {
  List newsList = [];
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _commentTextController = TextEditingController();
  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser.email);
    super.initState();
  }

  bool isLiked = false;
  void toggleLike() async {
    isLiked = !isLiked;
    var isLikedCounter = isLiked ? 1 : -1;
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('news').doc(widget.postId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .collection('likes')
        .add({
      'postId': widget.postId,
      'LikedBy': currentUser.email,
      'Likes': isLikedCounter,
    });
    var likesSummary = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .get();
    var newLikesSummary = (likesSummary.data()?['summary']);

    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email]),
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('modelValues')
          .doc(widget.category)
          .set({'summary': newLikesSummary + isLikedCounter},
              SetOptions(merge: true));
      print("like should have been sent");
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('modelValues')
          .doc(widget.category)
          .set({'summary': newLikesSummary + isLikedCounter},
              SetOptions(merge: true));
      print("like should have been removed");
    }
  }

  // add a comment
  void addComment(String commentText) async {
    var sentiment = await getCommentSentiment(commentText);
    await FirebaseFirestore.instance
        .collection('news')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'postId': widget.postId,
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
      'CommentSentiment': sentiment,
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .collection('comments')
        .add({
      'postId': widget.postId,
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
      'CommentSentiment': sentiment,
    });
    var commentsSummary = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .get();
    var newCommentsSummary = (commentsSummary.data()?['summary']) + sentiment;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .set({'summary': newCommentsSummary}, SetOptions(merge: true));
  }

  final dio = Dio();
  Future<int> getCommentSentiment(String commentText) async {
    final commentSentiment = await dio.get(
        'https://sentimentanalysismodel.osamamo.repl.co/Sentiment?Comment=$commentText');
    print(commentSentiment.data);
    Map<String, dynamic> jsonComment = json.decode(commentSentiment.toString());
    String sentiment = jsonComment['Comment Sentiment'];
    print(sentiment);
    return (sentiment == 'Positive') ? 1 : -1;
  }

  // show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Comment"),
              content: TextField(
                controller: _commentTextController,
                decoration:
                    const InputDecoration(hintText: "Write a comment.. "),
              ),
              actions: [
                // save Button
                TextButton(
                  onPressed: () async {
                    addComment(_commentTextController.text);
                    getCommentSentiment(_commentTextController.text);
                    Navigator.pop(context);
                    _commentTextController.clear();
                  },
                  child: const Text("Post"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _commentTextController.clear();
                  },
                  child: const Text("Cancel"),
                ),
                // cancel Button
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List bookMarksList = HiveHelper.bookMarks.values.toList();
  final stopwatch = Stopwatch();
  int index = HiveHelper.bookMarks.length + 1;
  final textController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final postsRef = FirebaseFirestore.instance.collection('news');
  Map likes = {};
  int likeCount = 0;

  void addBookmarkItems(String imageUrl, String category, String title,
      String source, String date, String content) async {
    HiveHelper.bookMarks.add(HiveBookMarkModel(
      urlToImage: widget.imageUrl,
      source: widget.source,
      title: widget.title,
      publishedAt: widget.date,
      category: widget.category,
      content: (widget.content),
      author: '',
      description: '',
      url: '',
    ));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .collection('bookMarks')
        .add({
      'postId': widget.postId,
      'BookMarkedBy': currentUser.email,
      'BookMarkedTime': Timestamp.now(),
      'BookMarkSentiment': 2,
    });
    var bookMarksSummary = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .get();
    var newBookMarkSummary = (bookMarksSummary.data()?['summary']) + 2;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('modelValues')
        .doc(widget.category)
        .set({'summary': newBookMarkSummary}, SetOptions(merge: true));
    log("added");
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetailScreen(
                    imageUrl: widget.imageUrl,
                    source: widget.source,
                    title: widget.title,
                    date: widget.date,
                    category: widget.category,
                    content: (widget.content),
                  ))),
      child: VisibilityDetector(
        key: Key(widget.title.toString()),
        onVisibilityChanged: (info) async {
          if (info.visibleFraction == 1 && !stopwatch.isRunning) {
            stopwatch.start();
            log(widget.title, name: 'start');
            print(widget.title);
          }
          if (info.visibleFraction < 0.5 && stopwatch.isRunning) {
            log(widget.title, name: 'reset');
            log("${stopwatch.elapsed}", name: "spent time");
            stopwatch.stop();
            await FirebaseFirestore.instance
                .collection('news')
                .doc(widget.postId)
                .collection('scroll')
                .add({
              'User': currentUser.email,
              'ScrollingTime': stopwatch.elapsed.toString(),
            });
            var scrollingTimeResult =
                (stopwatch.elapsed > const Duration(seconds: 10)) ? 1 : 0;
            var scrollingTime = stopwatch.elapsed.toString();
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserId)
                .collection('modelValues')
                .doc(widget.category)
                .collection('scrolling')
                .add({
              'postId': widget.postId,
              'ScrolledBy': currentUser.email,
              'ScrollingTime': scrollingTime,
            });
            var scrollingSummary = await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserId)
                .collection('modelValues')
                .doc(widget.category)
                .get();
            var newScrollingSummary = (scrollingSummary.data()?['summary']) ??
                0 + scrollingTimeResult;
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserId)
                .collection('modelValues')
                .doc(widget.category)
                .set({'summary': newScrollingSummary}, SetOptions(merge: true));

            print("scrolling time added to firebase");
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 20.0,
                        spreadRadius: -20.0,
                        offset: Offset(0.0, 20.0),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.imageUrl,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.category),
                                )),
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                  onTap: () async {
                                    addBookmarkItems(
                                        widget.imageUrl,
                                        widget.category,
                                        widget.category,
                                        widget.source,
                                        widget.date,
                                        widget.content);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Added Successfully')));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.bookmark_add_outlined,
                                        size: 24,
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            LikeButton(
                                              isLiked: isLiked,
                                              onTap: toggleLike,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                widget.likes.length.toString()),
                                          ],
                                        ))),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CommentButton(
                                                onTap: showCommentDialog),
                                          ],
                                        ))),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.source,
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 16),
                          ),
                          Text(
                            widget.date.substring(0, 11),
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // comment section
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('news')
                            .doc(widget.postId)
                            .collection('comments')
                            .orderBy("CommentTime", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((doc) {
                              final commentData =
                                  doc.data() as Map<String, dynamic>;

                              return Comment(
                                text: commentData["CommentText"],
                                user: commentData["CommentedBy"],
                                time: formatDate(commentData["CommentTime"]),
                              );
                            }).toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
