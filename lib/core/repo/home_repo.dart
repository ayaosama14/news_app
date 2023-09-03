import 'package:dartz/dartz.dart';
import 'package:news_app/core/repo/failure.dart';

import '../models/news_model/comment_model.dart';
import '../models/news_model/news_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<NewsModel>>> fetchBreakingNews();
  Future<Either<Failure, List<NewsModel>>> fetchRecommendationNews();
  // Future<Either<Failure, List<CommentModel>>> fetchCommentSentiment();
  // Future<Either<Failure,List<NewsModel>>> fetchNewsByCategory();
}
