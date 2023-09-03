part of 'signup_cubit.dart';

abstract class signupState extends Equatable {
  const signupState();

  @override
  List<Object> get props => [];
}

class signupInitialState extends signupState {}

class signupLoadingState extends signupState {}

class signupSuccessState extends signupState {}

class signupErrorState extends signupState {
  final String errMessage;

  const signupErrorState(this.errMessage);
}
