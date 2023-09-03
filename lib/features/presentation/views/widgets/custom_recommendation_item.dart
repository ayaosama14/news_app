import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/other_screens/item_detail_screen.dart';

class CustomRecommendationItem extends StatelessWidget {
  const CustomRecommendationItem({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.source,
    required this.date,
    required this.content,
  });

  final String imageUrl;
  final String category;
  final String title;
  final String source;
  final String date;
  final String content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetailScreen(
                    imageUrl: imageUrl,
                    source: source,
                    title: title,
                    category: category,
                    date: date,
                    content: (content * 3).substring(0),
                  ))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                child:
                    // (imageUrl!.isEmpty)?
                    CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                  width: 120,
                  height: 120,
                )
                // : Container(
                //     height: 120,
                //     width: 120,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //     ),
                //     child: const Center(child: Text("No Image")),
                //   ),
                ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .62,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      category,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          source,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        Text(
                          date.substring(0, 10),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
