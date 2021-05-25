import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsgupshup/core/widgets/google_sign_in_button.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_event.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_states.dart';

extension EmailCheck on String {
  bool get validEmail {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(this);
  }
}

class LoginScreen extends StatefulWidget {
  final LoginBloc bloc;
  LoginScreen({required this.bloc});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  loginView() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Enter Email"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Enter Password"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (_emailController.text.validEmail) {
                      widget.bloc.add(
                        CreateUserWithEmail(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Enter valid E-mail");
                    }
                  },
                  child: MediumTextView("Register"),
                ),
                MaterialButton(
                  color: Colors.amber,
                  onPressed: () {
                    if (_emailController.text.validEmail) {
                      widget.bloc.add(
                        SignInWithEmail(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Enter valid E-mail");
                    }
                  },
                  child: MediumTextView("Submit"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: SmallTextView(
              "or",
              textColor: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GoogleSignInButton(
            onPressed: () {
              widget.bloc.add(MakeUserLoginEvent());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextView('Log in '),
      ),
      body: Container(
        child: Center(
          child: BlocBuilder(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is UserNotLoggedInState) {
                return loginView();
              } else if (state is UserLoggedInFailed) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  Fluttertoast.showToast(msg: state.message);
                });
                return loginView();
              } else if (state is UserLoggedInState) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  Fluttertoast.showToast(msg: state.message);
                });
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
