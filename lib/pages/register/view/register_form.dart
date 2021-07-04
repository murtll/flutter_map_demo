import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _emailController,
      _passwordController,
      _usernameController,
      _passwordConfirmController;

  RegisterCubit _registerCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _registerCubit = BlocProvider.of<RegisterCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocConsumer(
            cubit: _registerCubit,
            listener: (context, state) async {
              if (state is RegisterLoading) {
                _showLoadingBar(state.message);
              }
              if (state is RegisterSuccess) {
                _showSuccessBar();

                username = state.result;

                await Future.delayed(Duration(seconds: 3));
                Navigator.pop(context);
              }
              if (state is RegisterFailed) {
                _showFailedBar();
              }
            },
            builder: (context, state) {
              return Container(
                  margin: EdgeInsets.only(left: 60, right: 60, top: 90),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: _usernameController,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(color: Colors.grey[600])),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(color: Colors.grey[600]))),
                        ),
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
                        TextFormField(
                          validator: (val) => _passwordController.text != val
                              ? "Passwords must match!"
                              : null,
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: _passwordConfirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Repeat password',
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
                          onPressed: _sendDataToRegisterCubit,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Theme.of(context).primaryColorDark,
                          child: Text('Register',
                              style: Theme.of(context).textTheme.button),
                        ),
                      ],
                    ),
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
            Text('Registration failed'),
            // CircularProgressIndicator()
          ],
        ),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: _sendDataToRegisterCubit,
        ),
      ));

  _showSuccessBar() => Scaffold.of(context).showSnackBar(SnackBar(
        // backgroundColor: Colors.grey,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('You have registered successfully!'),
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

  _sendDataToRegisterCubit() {
    if (_formKey.currentState.validate()) {
      SystemChannels.textInput.invokeListMethod("TextInput.hide");

      _registerCubit.register({
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text
      });
    }
  }
}
