import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/controller/friendList_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/friend_list.dart';
import 'package:fakeingbar/pages/profile_page.dart';
import 'package:fakeingbar/pages/userday_toggol_page.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/single_chat_row.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();
  final FriendListController _friendListController = Get.find();
  final DatabaseController _databaseController = Get.find();
  TextEditingController _newChatName = TextEditingController();

  final List<FriendListModel> _users = [];

  String? friendListUserImage;

  @override
  void initState() {
    _users.addAll(_friendListController.demoUsers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _appbarSection(context),
            _searchSection(),
            _daySection(),
            ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ...List.generate(_users.length,
                    (index) => SingleChatRow(user: _users[index]))
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _themeController.toggleThemeData(),
                child: const Text('Change Theme'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(context),
    );
  }

  SizedBox _bottomNav(BuildContext context) {
    return SizedBox(
      height: customWidth(.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Icon(
                FontAwesomeIcons.solidComment,
                size: 25.0,
              ),
              Text(
                'Chat',
                style: TextStyle(color: _themeController.textColor),
              )
            ],
          ),
          SizedBox(
            width: 40.0,
          ),
          PopupMenuButton(
            key: _key,
            onSelected: (value) {
              value == 1
                  ? showDialog(
                      context: context,
                      builder: (context) => _createChatDialog(),
                    )
                  : value == 2
                      ? showDialog(
                          context: context,
                          builder: (context) => _createGroupChatDialog(),
                        )
                      : null;
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                padding: EdgeInsets.only(left: customWidth(.09)),
                value: 1,
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Create Chat",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _themeController.textColor,
                            ),
                      ),
                      Icon(Icons.person_add),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                padding: EdgeInsets.only(left: customWidth(.09)),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text(
                        "Create Group",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _themeController.textColor,
                            ),
                      ),
                      Icon(Icons.person_add),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                padding: EdgeInsets.only(left: customWidth(.09)),
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      Text(
                        "Add Contact",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: _themeController.textColor,
                            ),
                      ),
                      Icon(Icons.perm_contact_cal),
                    ],
                  ),
                ),
              ),
            ],
            child: Column(
              children: [
                Icon(
                  Icons.people,
                  color: Colors.grey,
                  size: 30.0,
                ),
                Text(
                  "People",
                  style: TextStyle(
                    color: _themeController.textColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Dialog _createChatDialog() => Dialog(
        child: IntrinsicHeight(
          // height: customWidth(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: _themeController.backgroundColor,
                padding: EdgeInsets.symmetric(
                    horizontal: customWidth(.04), vertical: customWidth(.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create New Chat",
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: customWidth(.05),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              GestureDetector(
                onTap: () async => friendListUserImage =
                    await _friendListController.pickImage(),
                child: Container(
                  width: customWidth(.2),
                  height: customWidth(.2),
                  padding: EdgeInsets.all(customWidth(.02)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: SThemeData.lightThemeColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      friendListUserImage == null
                          ? Image.asset(
                              "images/person.png",
                              fit: BoxFit.contain,
                            )
                          : Image.file(File(friendListUserImage!)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _themeController.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: _themeController.darkenTextColor,
                            size: customWidth(.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              TextField(
                controller: _newChatName,
                decoration: InputDecoration(
                  hintText: "Enter Chat Name",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _themeController.textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: customWidth(.04),
                ),
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: SThemeData.lightThemeColor,
                    ),
                    onPressed: () async {
                      if (_newChatName.text != "" &&
                          friendListUserImage!.isNotEmpty) {
                        _chatListController.addNewChat(
                          name: _newChatName.text,
                          imageUrl: "images/person.png",
                          msg: "hi",
                          lastOnlineTime: "lastOnlineTime",
                          isOnline: true,
                          hasDay: true,
                          isBlock: false,
                        );
                        int id = await _databaseController
                            .insertUser(FriendListModel(
                          name: _newChatName.text,
                          imageUrl: friendListUserImage,
                          lastMessageTime: DateTime.now(),
                          lastMessage: "",
                          inactiveTime: "",
                        ));
                        _databaseController.insertChat(ChatListModel(
                            friendListID: id,
                            sendMessage: '',
                            memberID: '',
                            receiveMessage: "",
                            senderTime: DateTime.now(),
                            receiveTime: DateTime.now(),
                            isReceived: "not received"));

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: customWidth(.05),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.02),
              ),
            ],
          ),
        ),
      );

  Dialog _createGroupChatDialog() => Dialog(
        child: IntrinsicHeight(
          // height: customWidth(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: _themeController.backgroundColor,
                padding: EdgeInsets.symmetric(
                    horizontal: customWidth(.04), vertical: customWidth(.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create New Group Chat",
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: customWidth(.05),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              GestureDetector(
                onTap: () async =>
                    friendListUserImage = await _chatListController.pickImage(),
                child: Container(
                  width: customWidth(.2),
                  height: customWidth(.2),
                  padding: EdgeInsets.all(customWidth(.02)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: SThemeData.lightThemeColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      friendListUserImage == null
                          ? Image.asset(
                              "images/person.png",
                              fit: BoxFit.contain,
                            )
                          : Image.file(File(friendListUserImage!)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _themeController.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: _themeController.darkenTextColor,
                            size: customWidth(.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              TextField(
                controller: _newChatName,
                decoration: InputDecoration(
                  hintText: "Enter Chat Name",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _themeController.textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: customWidth(.04),
                ),
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: SThemeData.lightThemeColor,
                    ),
                    onPressed: () {
                      if (_newChatName.text != "") {
                        _chatListController.addNewChat(
                          name: _newChatName.text,
                          imageUrl: "images/person.png",
                          msg: "hi",
                          lastOnlineTime: "lastOnlineTime",
                          isOnline: true,
                          hasDay: true,
                          isBlock: false,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: customWidth(.05),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.02),
              ),
            ],
          ),
        ),
      );

  _showPeopleMenu(Offset offset) async {
    RenderBox? overlay =
        Overlay.of(context)!.context.findRenderObject()! as RenderBox?;
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        top,
        overlay!.size.width - left,
        overlay.size.height - top,
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.only(left: customWidth(.12)),
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Create Chat",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: _themeController.textColor,
                      ),
                ),
                Icon(Icons.person_add),
              ],
            ),
          ),
          onTap: () {
            Get.back();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(),
            );
            print('Create Chat');
          },
        ),
        PopupMenuItem(
          padding: EdgeInsets.only(left: customWidth(.12)),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  "Create Group",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: _themeController.textColor,
                      ),
                ),
                Icon(Icons.person_add),
              ],
            ),
          ),
          onTap: () {
            print('Create Group');
          },
        ),
        PopupMenuItem(
          padding: EdgeInsets.only(left: customWidth(.12)),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  "Add Contact",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: _themeController.textColor,
                      ),
                ),
                Icon(Icons.perm_contact_cal),
              ],
            ),
          ),
          onTap: () {
            print('Add Contact');
          },
        ),
      ],
      elevation: 8.0,
    );
  }

  Row _appbarSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.to(() => ProfilePage()),
          child: Padding(
            padding: EdgeInsets.only(
              top: customWidth(.03),
              left: customWidth(.05),
              bottom: customWidth(.03),
              right: customWidth(.05),
            ),
            child: Container(
                width: customWidth(.16),
                height: customWidth(.16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _themeController.scaffoldBackgroundColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  // child: _themeController.imageFile != null
                  //     ? Image.file(
                  //         _themeController.imageFile!,
                  //         fit: BoxFit.cover,
                  //       )
                  //     : _themeController.pref!.getString("profilePicPath") !=
                  //             null
                  //         ? Image.asset(
                  //             _themeController.pref!
                  //                 .getString("profilePicPath")!,
                  //             fit: BoxFit.cover)
                  //         : Image.asset(
                  //             'images/m1.jpg',
                  //             fit: BoxFit.cover,
                  //           ),
                  child: Image.asset(_themeController.profilePicPath.value,
                      fit: BoxFit.cover),
                )),
          ),
        ),
        Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: customWidth(.065),
            color: _themeController.textColor,
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.all(customWidth(.026)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(customWidth(.018)),
                decoration: BoxDecoration(
                  color: _themeController.backgroundColor,
                  borderRadius: BorderRadius.circular(customWidth(.06)),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: _themeController.textColor,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .035),
              Container(
                padding: EdgeInsets.all(customWidth(.018)),
                decoration: BoxDecoration(
                  color: _themeController.backgroundColor,
                  borderRadius: BorderRadius.circular(customWidth(.06)),
                ),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: _themeController.textColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _searchSection() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: customWidth(.04),
        vertical: customWidth(.03),
      ),
      height: customWidth(.12),
      child: TextField(
        readOnly: true,
        strutStyle: const StrutStyle(),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            color: _themeController.darkenTextColor,
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            color: _themeController.darkenTextColor,
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(customWidth(0.5)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(customWidth(0.5)),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }

  _daySingleWidget(FriendListModel user) {
    return Container(
      width: customWidth(.2),
      height: customWidth(.3),
      padding: EdgeInsets.symmetric(horizontal: customWidth(.025)),
      // decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: <Widget>[
          CustomeCircleAvatar(
            hasDay: user.hasDay!,
            imageUrl: user.imageUrl!,
            isOnline: user.isOnline!,
          ),
          Container(
            child: Text(
              user.name!,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _themeController.textColor,
                  fontSize: customWidth(.036)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _daySection() {
    return SizedBox(
      height: customWidth(.3),
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: customWidth(.025),
          ),
          GestureDetector(
            onTap: () => Get.to(() => UserDayToggolPage()),
            child: Container(
              width: customWidth(.2),
              padding: EdgeInsets.symmetric(horizontal: customWidth(.025)),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: customWidth(.08),
                    child: Center(
                      child: Icon(
                        Icons.video_call,
                        color: _themeController.isLite.value
                            ? Colors.black
                            : Colors.white,
                        size: customWidth(.08),
                      ),
                    ),
                    backgroundColor: _themeController.backgroundColor,
                  ),
                  Text(
                    "Create room",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _themeController.textColor,
                      fontSize: customWidth(.036),
                    ),
                  )
                ],
              ),
            ),
          ),
          ...List.generate(
              _users.length, (index) => _daySingleWidget(_users[index])),
        ],
      ),
    );
  }
}
