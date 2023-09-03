part of 'top_headlines_cubit.dart';

abstract class TopHeadlinesState extends Equatable {
  const TopHeadlinesState();

  @override
  List<Object> get props => [];
}

class TopHeadlinesInitial extends TopHeadlinesState {}

class TopHeadlinesLoading extends TopHeadlinesState {}

class TopHeadlinesFailure extends TopHeadlinesState {
  final String errMessage;

  const TopHeadlinesFailure(this.errMessage);
}

class TopHeadlinesSuccess extends TopHeadlinesState {
  final List<NewsModel> news;

  const TopHeadlinesSuccess(this.news);
}
