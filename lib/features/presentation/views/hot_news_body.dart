import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/manager/every_news/every_news_cubit.dart';
import 'package:news_app/features/presentation/views/widgets/custom_error_widget.dart';
import 'package:news_app/features/presentation/views/widgets/custom_loading_indicator.dart';
import 'package:news_app/features/presentation/views/widgets/custom_recommendation_item.dart';
import 'package:news_app/features/presentation/views/widgets/main_carousal_slider.dart';
import 'package:news_app/features/presentation/views/widgets/main_title.dart';

class HotNewsBody extends StatefulWidget {
  const HotNewsBody({super.key});

  @override
  State<HotNewsBody> createState() => _HotNewsBodyState();
}

class _HotNewsBodyState extends State<HotNewsBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainTitle(text: 'Breaking News', url: " "),
          const MainCarousalSlider(),
          const MainTitle(text: 'Recommendation', url: " "),
          BlocBuilder<EveryNewCubit, EveryNewState>(
            builder: (context, state) {
              if (state is EveryNewSuccess) {
                return Expanded(
                  child: ListView.builder(
                      // itemCount: state.news.length,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return CustomRecommendationItem(
                          imageUrl: '${state.news[index].urlToImage}',
                          source: '${state.news[index].source!.id}',
                          date: ' ${state.news[index].publishedAt!}',
                          category: '${state.news[index].category}',
                          title: '${state.news[index].title}',
                          content: '${state.news[index].content}',
                        );
                      }),
                );
              } else if (state is EveryNewFailure) {
                print(state.failure.toString());
                return CustomErrorWidget(errMessage: state.failure);
              } else {
                return const CustomLoadingIndicator();
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('sign out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
