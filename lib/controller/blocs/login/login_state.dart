part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final LoginDataModel loginDataModel;
  const LoginLoaded({required this.loginDataModel});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginConnectionError extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  final String errorString;
  const LoginFailure({required this.errorString});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
