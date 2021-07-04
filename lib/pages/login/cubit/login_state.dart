part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {
  final String message;
  LoginLoading({this.message});

  @override
  List<Object> get props => [message];
}

class LoginFailed extends LoginState {}