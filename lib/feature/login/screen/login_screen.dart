import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsgupshup/core/widgets/google_sign_in_button.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_event.dart';
import 'package:letsgupshup/feature/login/bloc/login_bloc_states.dart';

class LoginScreen extends StatefulWidget {
  final LoginBloc bloc;
  LoginScreen({required this.bloc});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
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
                return GoogleSignInButton(
                  onPressed: () {
                    widget.bloc.add(MakeUserLoginEvent());
                  },
                );
              } else if (state is UserLoggedInFailed) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  Fluttertoast.showToast(msg: state.message);
                });
                return GoogleSignInButton(
                  onPressed: () {
                    widget.bloc.add(MakeUserLoginEvent());
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
