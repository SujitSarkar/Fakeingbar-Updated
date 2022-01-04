import 'dart:ffi';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/chat_appbar.dart';
import 'package:fakeingbar/widgets/chat_bubble.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
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
  final _isScroll = true;

  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();

  List<ChatListModel> _chatList = [];
  List<String> chatSetting = [];

  final _textBox = "".obs;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    chatSetting = [
      "Block",
      "Set Profile Picture",
      "Add Date/Time",
      "Chat Settings",
    ];
    _chatList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        // _chatList
        //     // .addAll(_databaseController.chatList);

        _chatList.addAll(_databaseController.currentUserChats);
        print("ChatList: $_chatList");
        return WillPopScope(
          onWillPop: () async {
            _databaseController.currentUserChats.clear();
            debugPrint("${_databaseController.currentUserChats.length}");
            return true;
          },
          child: Scaffold(
            body: Column(
              children: <Widget>[
                _buildAppBar(_databaseController),
                _buildChat(_databaseController),
                _buildBottomChat(_databaseController),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildChat(DatabaseController _databaseController) {
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
                ? Text(
                    _databaseController.currentUser.value.welcomeMessage!,
                    style: TextStyle(
                      color: _themeController.textColor,
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: customWidth(.015),
            ),
            !_databaseController.currentUser.value.hasGroup!
                ? Text(
                    "Lives in ${_databaseController.currentUser.value.address}",
                    style: TextStyle(
                      color: _themeController.darkenTextColor,
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: customWidth(.03),
            ),
            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                // if (index != ListYourFriendChat.length - 1) {
                return ChatBubble(
                  chatList: _databaseController.currentUserChats[index],
                  user: _databaseController.currentUser.value,
                );
                //} else {
                //return
              },
              itemCount: _databaseController.currentUserChats.length,
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(DatabaseController _databaseController) {
    return ChatAppBarAction(
      isScroll: _isScroll,
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
  }

  _buildBottomChat(DatabaseController _databaseController) {
    return _databaseController.currentUser.value.isBlock == false
        ? Container(
            decoration: BoxDecoration(
              color: _themeController.scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10),
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
                        color: SThemeData.chatColors[
                            _databaseController.currentUser.value.chatColor!],
                      ),
                      Icon(
                        CupertinoIcons.photo,
                        size: 20.0,
                        color: SThemeData.chatColors[
                            _databaseController.currentUser.value.chatColor!],
                      ),
                      Icon(
                        CupertinoIcons.mic_solid,
                        size: 20.0,
                        color: SThemeData.chatColors[
                            _databaseController.currentUser.value.chatColor!],
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
                  padding: EdgeInsets.symmetric(horizontal: customWidth(0.03)),
                  child: GestureDetector(
                    onTap: () {
                      if (_textBox.isNotEmpty) {
                        _databaseController.insertChat(ChatListModel(
                            friendListID:
                                _databaseController.currentUser.value.id,
                            sendMessage: _textBox.value,
                            memberID: '',
                            receiveMessage: "hi",
                            senderTime: DateTime.now(),
                            receiveTime: DateTime.now(),
                            isReceived: "received"));
                        _databaseController.updateUser(
                          _databaseController.currentUser.value.copyWith(
                              lastMessage: _textBox.value,
                              lastMessageTime: DateTime.now()),
                          _databaseController.currentUser.value.id!,
                        );

                        _textBox.value = "";
                        _textEditingController.clear();
                      }
                    },
                    child: Obx(() => Icon(
                          _textBox.isEmpty
                              ? FontAwesomeIcons.solidThumbsUp
                              : Icons.send,
                          size: 22.0,
                          color: SThemeData.chatColors[
                              _databaseController.currentUser.value.chatColor!],
                        )),
                  ),
                ),
              ],
            ))
        : Container(
            height: customWidth(.175),
            width: double.infinity,
            color: SThemeData.lightThemeColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 10),
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
  }
}

class AppBarNetworkRoundedImage extends StatelessWidget {
  final String? imageUrl;
  const AppBarNetworkRoundedImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
