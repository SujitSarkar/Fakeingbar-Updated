import 'dart:ffi';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/chat_appbar.dart';
import 'package:fakeingbar/widgets/chat_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// const listYourFriendChat = [
//   'Nice to meet you!',
//   'Hello',
// ];
// const listYourChat = [
//   'Nice to meet you!',
//   'Hi',
// ];

class Chat extends StatefulWidget {
  final User user;
  const Chat({Key? key, required this.user}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _isScroll = true;

  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();

  List<ChatList> _chatList = [];
  List<String> chatSetting = [];

  TapDownDetails? _pressDetails;

  @override
  void initState() {
    _chatList = _chatListController.chatlist;
    chatSetting = [
      "Block",
      "Set Profile Picture",
      "Add Date/Time",
      "Chat Settings",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            _buildChat(),
            _buildBottomChat(),
          ],
        ),
      ),
    );
  }

  Expanded _buildChat() {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          // if (index != ListYourFriendChat.length - 1) {
          return ChatBubble(
            chatList: _chatList[index],
            user: widget.user,
          );
          //} else {
          //return
        },
        itemCount: _chatList.length,
      ),
    );
  }

  _buildAppBar() {
    return ChatAppBarAction(
      isScroll: _isScroll,
      isBack: true,
      isOnline: widget.user.isOnline,
      title: widget.user.name, //widget.friendItem!.name,
      imageUrl: widget.user.imageUrl, //widget.friendItem!.imageAvatarUrl,
      subTitle: widget.user.isOnline == true
          ? 'Active now'
          : "Active ${widget.user.lastOnlineTime}",
      user: widget.user,
    );
  }

  _buildBottomChat() {
    return Obx(() => _chatListController.isUserBlocked.isTrue
        ? Container(
            decoration: BoxDecoration(
              color: _themeController.scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: 20.0,
                  width: 22.0,
                  decoration: const BoxDecoration(
                    //borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage('images/noun_menu.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FontAwesomeIcons.camera,
                        size: 20.0,
                        color: Colors.deepPurpleAccent,
                      ),
                      Icon(
                        CupertinoIcons.photo,
                        size: 20.0,
                        color: Colors.deepPurpleAccent,
                      ),
                      Icon(
                        CupertinoIcons.mic_solid,
                        size: 20.0,
                        color: Colors.deepPurpleAccent,
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
                          suffixIcon: const Icon(
                            FontAwesomeIcons.solidSmileBeam,
                            size: 22.0,
                            color: Colors.deepPurpleAccent,
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.solidThumbsUp,
                      size: 22.0,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                )
              ],
            ))
        : Container(
            height: customWidth(.2),
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
          ));
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
