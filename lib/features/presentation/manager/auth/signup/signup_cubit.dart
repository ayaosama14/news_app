import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/models/user_model.dart';

part 'signup_state.dart';

class signupCubit extends Cubit<signupState> {
  signupCubit() : super(signupInitialState());

  void userRegister({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String? imgUrl,
    bool? isPhoneVerified,
  }) async {
    emit(signupLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCreate(
        email: email,
        password: password,
        uId: userCredential.user!.uid,
        fullName: fullName,
        imgUrl: imgUrl,
        phone: phone,
        isPhoneVerified: isPhoneVerified,
      );

      print('Data Saved Successfully');
      emit(signupSuccessState());
    } catch (e) {
      emit(signupErrorState(e.toString()));
    }
  }
}

Future<void> userCreate({
  required String email,
  required String password,
  required String uId,
  required String fullName,
  String? imgUrl,
  String? phone,
  bool? isPhoneVerified,
}) async {
  UserModel model = UserModel(
    email: email,
    uId: uId,
    fullName: fullName,
    imgUrl: imgUrl,
    phone: phone,
    password: password,
    isPhoneVerified: false,
  );
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap());
}
