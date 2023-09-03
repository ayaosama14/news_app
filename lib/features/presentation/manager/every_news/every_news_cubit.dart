import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/models/news_model/news_model.dart';
import 'package:news_app/core/repo/home_repo.dart';

import '../../../../core/repo/firestore.dart';

part 'every_new_state.dart';

class EveryNewCubit extends Cubit<EveryNewState> {
  EveryNewCubit(this.homeRepo) : super(EveryNewInitial());
  final HomeRepo homeRepo;
  Future<void> fetchEveryNews() async {
    emit(EveryNewLoading());
    var result = await homeRepo.fetchRecommendationNews();
    // var result = await FirebaseFirestore.instance.collection('news').snapshots();
    result.fold((failure) {
      emit(EveryNewFailure(failure.errMessage));
    }, (news) {
      var documentId = FirebaseFirestore.instance.collection('news').doc();

      // Firestore.uploadNewsToFirebase(news);

      emit(EveryNewSuccess(news));
    });
  }
}
