import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:letsgupshup/core/widgets/my_custom_text_widget.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc_event.dart';
import 'package:letsgupshup/feature/chat/bloc/chat_bloc_state.dart';
import 'package:letsgupshup/feature/chat/domain/model/message.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:letsgupshup/core/utils/firebase_configure.dart';

class ChatOneOnOne extends StatefulWidget {
  final String peerId;
  final String? peerAvatar;
  final String peerName;
  final ChatBloc bloc;
  const ChatOneOnOne({
    Key? key,
    required this.peerId,
    required this.peerAvatar,
    required this.peerName,
    required this.bloc,
  }) : super(key: key);
  @override
  _ChatOneOnOneState createState() => _ChatOneOnOneState();
}

class _ChatOneOnOneState extends State<ChatOneOnOne> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  late String peerId;

  late String groupChatId;

  final ScrollController listScrollController = ScrollController();
  void onFocusChange() {
    if (focusNode.hasFocus) {}
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(onFocusChange);

    // CREATE CHAT ID
    widget.bloc.add(CreateDocumentChatEvent(peerId: widget.peerId));
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = (await imagePicker.getImage(source: ImageSource.gallery))!;
    File imageFile = File(pickedFile.path);

    if (await imageFile.exists()) {
      // uploadFile(imageFile);
      await FireBaseConfig().uploadFile(imageFile.path, (String link) {
        onSendMessage(link, 1);
      });
    }
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image,
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      widget.bloc.add(
        SendMessageChatEvent(
          peerId: widget.peerId,
          content: content,
          messageType: type.toString(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Nothing to send',
        backgroundColor: Colors.black,
        textColor: Colors.red,
      );
    }
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
                // style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.green),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade100,
            width: 0.5,
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget buildListMessage(ChatState state) {
    if (state.messages == null) {
      return Expanded(child: Container());
    }

    return Flexible(
        child: StreamBuilder<List<Message>>(
      initialData: [],
      stream: state.messages,
      builder: (context, snapshot) {
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return buildItem(snapshot.data![index]);
          },
          // buildItem(index, snapshot.data![index]),
          itemCount: snapshot.data!.length,
          reverse: true,
        );
      },
    ));
  }

  Widget buildItem(Message message) {
    if (message.sender != widget.peerId) {
      // Right (my message)
      return Row(
        children: <Widget>[
          int.parse(message.messageType!) == 0
              // Text
              ? Container(
                  child: MediumTextView(
                    message.message,
                    textColor: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: message.recipient != widget.peerId ? 20.0 : 10.0,
                      right: 10.0),
                )
              : int.parse(message.messageType!) == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: message.message,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FullPhoto(
                          //             url: document.data()['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom:
                              message.recipient != widget.peerId ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  : Container(),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                message.recipient != widget.peerId
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl:
                              "https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png",
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                int.parse(message.messageType!) == 0
                    ? Container(
                        child: Text(
                          message.message,
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : int.parse(message.messageType!) == 0
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade300,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: message.message,
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) => FullPhoto(
                                //         url: document.data()['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(),
              ],
            ),

            // Time
            message.recipient != widget.peerId
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              message.createdTimestamp)),
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  Widget buildLoading(isLoading) {
    return Positioned(
      child: isLoading ? CircularProgressIndicator() : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LargeTextView("${widget.peerName}"),
      ),
      body: BlocBuilder(
        bloc: widget.bloc,
        builder: (context, ChatState state) {
          if (state is ErrorChatState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  FontAwesomeIcons.cross,
                  color: Colors.red,
                ),
                LargeTextView(state.errorMessage ??
                    "Some Error Occured. Try Again Later.")
              ],
            );
          }
          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  // List of messages
                  buildListMessage(state),

                  // Input content
                  buildInput(),
                ],
              ),
              buildLoading(state is LoadingChat),
            ],
          );
        },
      ),
    );
  }
}
