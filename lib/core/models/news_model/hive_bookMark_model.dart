import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'hive_bookMark_model.g.dart';

@HiveType(typeId: 0)
class HiveBookMarkModel extends HiveObject {
  @HiveField(0)
  late String source;
  @HiveField(1)
  late String author;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String description;
  @HiveField(4)
  late String url;
  @HiveField(5)
  late String urlToImage;
  @HiveField(6)
  late String publishedAt;
  @HiveField(7)
  late String content;
  @HiveField(8)
  late String category;

  HiveBookMarkModel({
    // required Key key,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.category,
  });
}
