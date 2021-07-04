import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:first_flutter_app/main.dart';
import 'package:first_flutter_app/pages/login/cubit/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(Map<String, dynamic> data) async {
    emit(LoginLoading(message: 'Logging in...'));

    final email = data['email'];
    final password = data['password'];

    try {
      await Future.delayed(Duration(seconds: 3));
      for (Map user in LoginRepository.sampleData) {
        if (user['email'] == email && user['password'] == password) {
          username = user['username'];
          emit(LoginSuccess());
          return;
        }
      }
      throw Exception();
    } catch (e) {
      emit(LoginFailed());
    }
    // emit(LoginInitial());
  }
}
