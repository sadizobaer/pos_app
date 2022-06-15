part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPassword(this.email, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginConnectionErrorEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}