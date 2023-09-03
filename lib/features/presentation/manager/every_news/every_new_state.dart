part of 'every_news_cubit.dart';

abstract class EveryNewState extends Equatable {
  const EveryNewState();

  @override
  List<Object> get props => [];
}

class EveryNewInitial extends EveryNewState {}

class EveryNewLoading extends EveryNewState {}

class EveryNewFailure extends EveryNewState {
  final String failure;

  const EveryNewFailure(this.failure);
}

class EveryNewSuccess extends EveryNewState {
  final List<NewsModel> news;

  const EveryNewSuccess(this.news);
}
