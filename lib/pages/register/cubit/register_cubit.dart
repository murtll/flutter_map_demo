import 'dart:math';

import 'package:first_flutter_app/pages/login/cubit/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(Map<String, dynamic> data) async {
    emit(RegisterLoading(message: 'Registration...'));

    final email = data['email'];
    final password = data['password'];
    final username = data['username'];

    try {
      await Future.delayed(Duration(seconds: 3));

      LoginRepository.sampleData.add(data);

      emit(RegisterSuccess(result: username));
    } catch (e) {
      emit(RegisterFailed());
    }
    // emit(RegisterInitial());
  }
}
