part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errMessage;

  const LoginErrorState(this.errMessage);
}

class LoginSuccessState extends LoginState {
  final String uId;

  const LoginSuccessState(this.uId);
}
