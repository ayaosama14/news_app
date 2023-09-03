import 'package:flinq/flinq.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/repo/hive_helper.dart';
import 'package:news_app/features/presentation/views/widgets/custom_recommendation_item.dart';

import '../../../../core/models/news_model/hive_bookMark_model.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  @override
  void initState() {
    // HiveHelper.bookMarks.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bookMarks.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ValueListenableBuilder<Box<HiveBookMarkModel>>(
          valueListenable: HiveHelper.bookMarks.listenable(),
          builder: (context, value, child) {
            final bookMarksList = value.values.distinct.toList();
            if (bookMarksList.isEmpty) {
              return const Center(
                child: Text("No Items yet, Add some"),
              );
            } else {
              return ListView.builder(
                itemCount: bookMarksList.length,
                itemBuilder: (context, index) {
                  return CustomRecommendationItem(
                    imageUrl: bookMarksList[index].urlToImage,
                    category: bookMarksList[index].category,
                    title: bookMarksList[index].title,
                    source: bookMarksList[index].source,
                    date: bookMarksList[index].publishedAt,
                    content: bookMarksList[index].content,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
