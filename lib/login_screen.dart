import 'package:flutter/material.dart';
import 'package:fusionauth_game/game_screen.dart';
import 'package:fusionauth_game/register_screen.dart';
import 'package:fusionauth_game/rounded_button.dart';
import 'package:fusionauth_game/textfield_border.dart';

import 'network.dart';

const _horizontalPadding = 32.0;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isBusy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Fusion Auth'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(_horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BorderedTextField(
                  hintText: 'Username',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null) {
                      return 'Empty Field';
                    }
                    if (value.isEmpty) {
                      return 'Empty Field';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                BorderedTextField(
                  hintText: 'Password',
                  obscured: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null) {
                      return 'Empty Field';
                    }
                    if (value.isEmpty) {
                      return 'Empty Field';
                    }
                    if (value.characters.length < 8) {
                      return 'Minimum Characters is 8';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _isBusy
                    ? CircularProgressIndicator()
                    : RoundedButton(
                        text: 'Login',
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isBusy = true;
                            });
                            var response = await NetworkApi.login(
                                _usernameController.text,
                                _passwordController.text);
                            setState(() {
                              _isBusy = false;
                            });
                            if (response.success) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GameScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(response.errorMessage!)));
                            }
                          }
                        },
                      ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text('Not Registered?'))
              ],
            ),
          ),
        ));
  }
}
