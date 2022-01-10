import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/chat_appbar.dart';
import 'package:fakeingbar/widgets/chat_bubble.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/k_chat_dialog.dart';
import 'package:fakeingbar/widgets/k_filled_button.dart';
import 'package:fakeingbar/widgets/k_voice_msg_sending_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key? key,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ThemeController _themeController = Get.find();

  List<String> chatSetting = [];

  final ScrollController _scrollController = ScrollController();

  final _textBox = "".obs;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _welcomeMsgController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late int userId;

  @override
  void initState() {
    chatSetting = [
      "Block",
      "Set Profile Picture",
      "Add Date/Time",
      "Chat Settings",
    ];

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        print("ChatList: ${_databaseController.currentUserChats}");
        userId = _databaseController.currentUser.value.id!;
        return WillPopScope(
          onWillPop: () async {
            _databaseController.currentUserChats.clear();
            debugPrint("${_databaseController.currentUserChats.length}");
            return true;
          },
          child: Scaffold(
            body: Column(
              children: <Widget>[
                _buildAppBar(),
                _buildChat(),
                _buildBottomChat(),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildChat() {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomeCircleAvatar(
                  user: _databaseController.currentUser.value,
                  picRadius: 50,
                  onlineDotSize: 0,
                ),
                SizedBox(
                  height: customWidth(.03),
                ),
                Text(
                  _databaseController.currentUser.value.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: customWidth(.065),
                    color: _themeController.textColor,
                  ),
                ),
                SizedBox(
                  height: customWidth(.015),
                ),
                !_databaseController.currentUser.value.hasGroup!
                    ? GestureDetector(
                        onTap: () {
                          showEditChatDialog(_databaseController);
                        },
                        child: Text(
                          _databaseController.currentUser.value.welcomeMessage!,
                          style: TextStyle(
                            color: _themeController.textColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: customWidth(.015),
                ),
                !_databaseController.currentUser.value.hasGroup!
                    ? GestureDetector(
                        onTap: () => showEditChatDialog(_databaseController),
                        child: Text(
                          "Lives in ${_databaseController.currentUser.value.address}",
                          style: TextStyle(
                            color: _themeController.darkenTextColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: customWidth(.03),
                ),
                Obx(
                  () => ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    // controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ChatBubble(
                        // chatList: _databaseController.currentUserChats[index],
                        index: _databaseController.currentUserChats[index].id!,
                        user: _databaseController.currentUser,
                      );
                    },
                    itemCount: _databaseController.currentUserChats.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showEditChatDialog(DatabaseController _databaseController) {
    return showDialog(
      context: context,
      builder: (context) => KChatDialog(
        firstText: _welcomeMsgController,
        secondText: _addressController,
        name: "Edit Chat",
        hintText1: _databaseController.currentUser.value.welcomeMessage!,
        hintText2: _databaseController.currentUser.value.address!,
        btnText: "Save",
        onPressed: () async {
          await _databaseController.updateUser(
              _databaseController.currentUser.value.copyWith(
                welcomeMessage: _welcomeMsgController.text.trim().isNotEmpty
                    ? _welcomeMsgController.text.trim()
                    : _databaseController.currentUser.value.welcomeMessage,
                address: _addressController.text.trim().isNotEmpty
                    ? _addressController.text.trim()
                    : _databaseController.currentUser.value.address,
              ),
              userId);

          _databaseController.updateCurrentUser(userId);
          Navigator.pop(context);
        },
      ),
    );
  }

  _buildAppBar() {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return ChatAppBarAction(
          isBack: true,
          isOnline: _databaseController.currentUser.value.isOnline!,
          title: _databaseController
              .currentUser.value.name!, //widget.friendItem!.name,
          imageUrl: _databaseController
              .currentUser.value.imageUrl!, //widget.friendItem!.imageAvatarUrl,
          subTitle: _databaseController.currentUser.value.isOnline == true
              ? 'Active now'
              : _databaseController.currentUser.value.inactiveTime != null
                  ? "Active ${_databaseController.currentUser.value.inactiveTime}"
                  : "offline",
          color: SThemeData
              .chatColors[_databaseController.currentUser.value.chatColor!],
        );
      },
    );
  }

  _buildBottomChat() {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return _databaseController.currentUser.value.isBlock == false
            ? Container(
                decoration: BoxDecoration(
                  color: _themeController.scaffoldBackgroundColor,
                ),
                padding:
                    const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                      width: 22.0,
                      decoration: const BoxDecoration(
                          //borderRadius: BorderRadius.circular(20.0),
                          // image: DecorationImage(
                          //   image: AssetImage('images/noun_menu.png'),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      child: SvgPicture.asset(
                        'assets/svg/image2vector.svg',
                        fit: BoxFit.scaleDown,
                        color: SThemeData.chatColors[
                            _databaseController.currentUser.value.chatColor!],
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.camera,
                            size: 20.0,
                            color: SThemeData.chatColors[_databaseController
                                .currentUser.value.chatColor!],
                          ),
                          GestureDetector(
                            onTap: () async {
                              await getImageForMessage(_databaseController);
                            },
                            child: Icon(
                              CupertinoIcons.photo,
                              size: 20.0,
                              color: SThemeData.chatColors[_databaseController
                                  .currentUser.value.chatColor!],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showVoiceMessageDialog(),
                            child: Icon(
                              CupertinoIcons.mic_solid,
                              size: 20.0,
                              color: SThemeData.chatColors[_databaseController
                                  .currentUser.value.chatColor!],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 50,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.width * .11,
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            _textBox(value);
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Aa',
                              filled: true,
                              hintStyle: TextStyle(
                                color: _themeController.darkenTextColor,
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.solidSmileBeam,
                                size: 22.0,
                                color: SThemeData.chatColors[_databaseController
                                    .currentUser.value.chatColor!],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: customWidth(0.03)),
                      child: GestureDetector(
                        onTap: () async {
                          if (_textBox.isNotEmpty &&
                              _textEditingController.text.trim().isNotEmpty) {
                            if (!DateTime.now().isBlank!) {
                              String reply = "";
                              _databaseController.trainerChatList.map((chat) {
                                if (chat.question ==
                                    _textEditingController.text.trim()) {
                                  print(
                                      "question: ${chat.question}, answer: ${chat.answer}");
                                  reply = chat.answer!;
                                  return;
                                }
                              });
                              await _databaseController.insertChat(
                                  ChatListModel(
                                      friendListID: _databaseController
                                          .currentUser.value.id,
                                      sendMessage:
                                          _textEditingController.text.trim(),
                                      memberID: '',
                                      messageType: "text",
                                      receiveMessage: reply,
                                      senderTime: DateTime.now(),
                                      receiveTime: DateTime.now(),
                                      isReceived: "received"));
                              await _databaseController.updateUser(
                                _databaseController.currentUser.value.copyWith(
                                    lastMessage:
                                        _textEditingController.text.trim(),
                                    lastMessageTime: DateTime.now()),
                                _databaseController.currentUser.value.id!,
                              );
                              _databaseController.updateCurrentUser(userId);

                              _textBox.value = '';
                              _textEditingController.clear();
                            }
                          }
                        },
                        child: Obx(
                          () => Icon(
                            _textBox.isEmpty
                                ? FontAwesomeIcons.solidThumbsUp
                                : Icons.send,
                            size: 22.0,
                            color: SThemeData.chatColors[_databaseController
                                .currentUser.value.chatColor!],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
            : Container(
                height: customWidth(.175),
                width: double.infinity,
                color: SThemeData.lightThemeColor,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 10),
                child: RichText(
                  text: const TextSpan(
                    text: "You can't reply to this conversation.",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "Learn More",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Future<void> getImageForMessage(
      DatabaseController _databaseController) async {
    File? image = await _databaseController.pickImage();
    if (image != null) {
      if (!DateTime.now().isBlank!) {
        await _databaseController.insertChat(ChatListModel(
            friendListID: _databaseController.currentUser.value.id,
            sendMessage: image.path,
            memberID: '',
            messageType: "image",
            receiveMessage: "hi",
            senderTime: DateTime.now(),
            receiveTime: DateTime.now(),
            isReceived: "received"));
        _databaseController.updateUser(
          _databaseController.currentUser.value.copyWith(
              lastMessage: "You sent an Image",
              lastMessageTime: DateTime.now()),
          _databaseController.currentUser.value.id!,
        );
        _databaseController.updateCurrentUser(userId);

        _textBox.value = '';
        _textEditingController.clear();
      }
    }
  }

  Future<dynamic> _showVoiceMessageDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return GetBuilder<DatabaseController>(
            builder: (_databaseController) {
              return KVoiceMsgSendingDialog(
                time: _timeController,
                hintText: "Set Time",
                btnText: "Send",
                onPressed: () async {
                  if (_timeController.text.trim().isNotEmpty) {
                    if (!DateTime.now().isBlank!) {
                      await _databaseController.insertChat(ChatListModel(
                          friendListID:
                              _databaseController.currentUser.value.id,
                          sendMessage: _timeController.text.trim(),
                          memberID: '',
                          messageType: "voice",
                          receiveMessage: "hi",
                          senderTime: DateTime.now(),
                          receiveTime: DateTime.now(),
                          isReceived: "received"));
                      await _databaseController.updateUser(
                        _databaseController.currentUser.value.copyWith(
                            lastMessage: "You sent a Voice",
                            lastMessageTime: DateTime.now()),
                        _databaseController.currentUser.value.id!,
                      );

                      _databaseController.updateCurrentUser(userId);

                      _timeController.clear();
                      Navigator.pop(context);
                    }
                  }
                },
              );
            },
          );
        });
  }
}
