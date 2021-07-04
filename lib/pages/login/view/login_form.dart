import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController, _passwordController;

  LoginCubit _loginCubit;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocConsumer(
            cubit: _loginCubit,
            listener: (context, state) async {
              if (state is LoginLoading) {
                _showLoadingBar(state.message);
              }
              if (state is LoginSuccess) {
                _showSuccessBar();

                await Future.delayed(Duration(seconds: 3));
                Navigator.pop(context);
              }
              if (state is LoginFailed) {
                _showFailedBar();
              }
            },
            builder: (context, state) {
              return Container(
                  margin: EdgeInsets.only(left: 60, right: 60, top: 110),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(TextStyle(color: Colors.grey[600])),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .merge(TextStyle(color: Colors.grey)),
                            hintText: 'example@google.com'),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .merge(TextStyle(color: Colors.grey[600])),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .merge(TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        minWidth: 100,
                        height: 40,
                        onPressed: _sendDataToLoginCubit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Theme.of(context).primaryColorDark,
                        child: Text('Log in',
                            style: Theme.of(context).textTheme.button),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FlatButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/register'),
                        child: Text(
                          'If you don`t have an account yet, register here',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .merge(TextStyle(color: Colors.blue[700])),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ));
            }));
  }

  _showFailedBar() => Scaffold.of(context).showSnackBar(SnackBar(
        // backgroundColor: Colors.grey,
        content: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.error_outline),
            SizedBox(
              width: 20,
            ),
            Text('Logging in failed'),
            // CircularProgressIndicator()
          ],
        ),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            _sendDataToLoginCubit();
          },
        ),
      ));

  _showSuccessBar() => Scaffold.of(context).showSnackBar(SnackBar(
        // backgroundColor: Colors.grey,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('You are currently logged in!'),
            // CircularProgressIndicator()
          ],
        ),
        // action: SnackBarAction(
        //   label: 'Stop',
        //   onPressed: () {  },
        // ),
      ));

  _showLoadingBar(String message) => Scaffold.of(context).showSnackBar(SnackBar(
        // backgroundColor: Colors.grey,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(message), CircularProgressIndicator()],
        ),
        action: SnackBarAction(
          label: 'Stop',
          onPressed: () {},
        ),
      ));

  _sendDataToLoginCubit() {
    SystemChannels.textInput.invokeListMethod("TextInput.hide");

    _loginCubit.login(
        {'email': _emailController.text, 'password': _passwordController.text});
  }
}
