import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/core/models/news_model/news_model.dart';

class Firestore {
  
  static Future<void> uploadNewsToFirebase(List<NewsModel> newsList) async {
    var document = FirebaseFirestore.instance.collection('news').doc();
    var collection = FirebaseFirestore.instance.collection('news');
    var snapshots = await collection.get();

    for (NewsModel newsItem in newsList) {
      await FirebaseFirestore.instance.collection('news').doc().set({
        'likes': [],
        'category': newsItem.category,
        'content': newsItem.content,
        'description': newsItem.description,
        'publishedAt': newsItem.publishedAt,
        'title': newsItem.title,
        'url': newsItem.url,
        'urlToImage': newsItem.urlToImage,
        'id': document.id,
        'source': newsItem.source?.id,
      });
    }

    final snapShot = await FirebaseFirestore.instance.collection('news').get();
    print(snapShot.docs.length);
    print("all items added to firebase");
  }

  static Future addOrUpdateWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    // Timer(const Duration(milliseconds: 500), () async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .update(data);
    // });
  }
}
