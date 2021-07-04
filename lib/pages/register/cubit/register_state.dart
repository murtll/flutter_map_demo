part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String result;
  RegisterSuccess({this.result});

  @override
  List<Object> get props => [result];
}

class RegisterLoading extends RegisterState {
  final String message;
  RegisterLoading({this.message});

  @override
  List<Object> get props => [message];
}

class RegisterFailed extends RegisterState {}