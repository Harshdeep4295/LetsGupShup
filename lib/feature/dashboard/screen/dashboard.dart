import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letsgupshup/core/routes/route_names.dart';
import 'package:letsgupshup/core/routes/routing.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';
import 'package:letsgupshup/core/utils/injector.dart';
import 'package:letsgupshup/core/utils/shared_pref.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc_events.dart';
import 'package:letsgupshup/feature/dashboard/bloc/dashboard_bloc_state.dart';
import 'package:letsgupshup/feature/chat/screen/chat.dart';
import 'package:letsgupshup/feature/login/domain/entities/user_model.dart';

class Dashboard extends StatefulWidget {
  DashboardBloc bloc;
  Dashboard({required this.bloc});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ScrollController listScrollController = ScrollController();
  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {}
  }

  Widget buildItem(UserModel model) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Material(
              child: model.photoUrl != null && model.photoUrl != ""
                  ? CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                        ),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(15.0),
                      ),
                      imageUrl: model.photoUrl!,
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 50.0,
                      color: Colors.green,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${model.name}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
          ],
        ),
        onPressed: () {
          AppRouting.navigateWithArgumentTo(CHAT_SCREEN, {
            "peerId": model.id,
            "peerAvatar": model.photoUrl,
            "peerName": model.name,
          });
        },
        color: Colors.grey.shade200,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextView('CHATS'),
        actions: [
          InkWell(
            onTap: () {
              googleSignIn.signOut();
              AppPreferences().clearAll();
              AppRouting.navigateTo(LOGIN_SCREEN);
            },
            child: Icon(
              FontAwesomeIcons.signOutAlt,
            ),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is UsersLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.model!.length,
              itemBuilder: (context, index) {
                return buildItem(state.model![index]);
              },
            );
          } else {
            return Container(
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    MaterialButton(
                      onPressed: () {
                        widget.bloc.add(LoadUser());
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
