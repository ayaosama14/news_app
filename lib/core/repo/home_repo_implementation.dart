import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/models/news_model/comment_model.dart';
import 'package:news_app/core/repo/failure.dart';
import 'package:news_app/core/models/news_model/news_model.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/repo/firestore.dart';
import 'package:news_app/core/repo/home_repo.dart';
import 'package:news_app/core/utils/api_service.dart';

// List<String> categoryParameterList = [];
List<String> categoryList = [
  'business',
  'entertainment',
  'general',
  'science',
  'sports',
  'technology',
  'health',
];

class HomeRepoImplementation extends HomeRepo {
  final ApiService apiService;

  HomeRepoImplementation(this.apiService);
  var newsDocumentReference =
      FirebaseFirestore.instance.collection('news').doc();

  @override
  Future<Either<Failure, List<NewsModel>>> fetchBreakingNews() async {
    try {
      List<NewsModel> news = [];
      for (int i = 0; i < categoryList.length; i++) {
        data = await apiService.get(
          endPoint:
              '/v2/top-headlines?country=us&category=${categoryList[i]}&apiKey=45e8aa2e58b4452b9141bdef4f0364ef',
        );
        print("${categoryList[i]} added successfully");
        for (var item in data['articles']) {
          if (NewsModel.fromJson(item).urlToImage != null) {
            news.add(NewsModel.fromJson(item));
          }
          news.last.category = categoryList[i];
        }
        news.shuffle();
        print(data['articles'].length);
      }
      // Firestore.uploadNewsToFirebase(news);

      // news.shuffle();

      return right(news);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  var documentId = FirebaseFirestore.instance.collection('news').doc().id;

  int x = 0;
  var data;
  @override
  Future<Either<Failure, List<NewsModel>>> fetchRecommendationNews() async {
    try {
      List<NewsModel> news = [];
      for (int i = 0; i < categoryList.length; i++) {
        data = await apiService.get(
          endPoint:
              '/v2/top-headlines?country=us&category=${categoryList[i]}&apiKey=bdcd432edce64b73b050a35f7def53cf',
      );
        print("${categoryList[i]} added successfully");
        for (var item in data['articles']) {
          if (NewsModel.fromJson(item).urlToImage != null) {
            NewsModel.fromJson(item);
            news.add(NewsModel.fromJson(item));
          }
          news.last.category = categoryList[i];
        }
        print(data['articles'].length);
      }

      // Firestore.uploadNewsToFirebase(news);
      news.shuffle();

      return right(news);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
