import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme,
          title: Text("Registration", style: Theme.of(context).textTheme.headline1)),
      body: BlocProvider(
          create: (context) => RegisterCubit(),
          child: RegisterForm(),
      ),
    );
  }
}
