import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/controller/friendList_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/pages/profile_page.dart';
import 'package:fakeingbar/pages/userday_toggol_page.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/k_dialog.dart';
import 'package:fakeingbar/widgets/k_filled_button.dart';
import 'package:fakeingbar/widgets/k_image_picker.dart';
import 'package:fakeingbar/widgets/single_chat_row.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final KSharedPreference _pref = Get.find();
  TextEditingController _newChatName = TextEditingController();
  // SharedPreferences? _pref1;
  // Future<void> initializeData() async {
  //   _pref1 = await SharedPreferences.getInstance();
  // }

  @override
  void initState() {
    // initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _appbarSection(context),
                Expanded(
                  child: ListView(
                    children: [
                      _searchSection(),
                      _daySection(_databaseController),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _themeController.toggleThemeData(),
                          child: const Text('Change Theme'),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _databaseController.userList.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SingleChatRow(
                              user: _databaseController.userList[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _bottomNav(context, _databaseController),
        );
      },
    );
  }

  SizedBox _bottomNav(
      BuildContext context, DatabaseController _databaseController) {
    return SizedBox(
      height: customWidth(.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              const Icon(
                FontAwesomeIcons.solidComment,
                size: 25.0,
              ),
              Text(
                'Chat',
                style: TextStyle(color: _themeController.textColor),
              )
            ],
          ),
          const SizedBox(
            width: 40.0,
          ),
          PopupMenuButton(
            key: _key,
            onSelected: (value) {
              value == 1
                  ? showDialog(
                      context: context,
                      builder: (context) =>
                          _createChatDialog(_databaseController),
                    )
                  : value == 2
                      ? showDialog(
                          context: context,
                          builder: (context) =>
                              _createGroupChatDialog(_databaseController),
                        )
                      : value == 3
                          ? getContact(context, _databaseController)
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
                      const Icon(Icons.person_add),
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
                      const Icon(Icons.person_add),
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
                      const Icon(Icons.perm_contact_cal),
                    ],
                  ),
                ),
              ),
            ],
            child: Column(
              children: [
                const Icon(
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

  getContact(
      BuildContext context, DatabaseController _databaseController) async {
    PermissionStatus status = await Permission.contacts.status;
    if (!status.isGranted) await Permission.contacts.request();
    if (await Permission.contacts.isGranted) {
      final contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        setState(() {
          _newChatName.text =
              "${contact.name.first} ${contact.name.middle} ${contact.name.last}";
          print(
              "${contact.name.first} ${contact.name.middle} ${contact.name.last}");
        });
      }

      showDialog(
          context: context,
          builder: (context) => _createChatDialog(_databaseController));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable contacts access '
              'permission in system settings'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }

  Widget _createChatDialog(DatabaseController _databaseController) => KDialog(
        name: "Create New Chat",
        hintText: "Enter Chat Name",
        btnText: "Create",
        newChatName: _newChatName,
        onPressed: () async {
          if (_newChatName.text != "") {
            // _chatListController.addNewChat(
            //   name: _newChatName.text,
            //   imageUrl: imageFile!.path,
            //   msg: "hi",
            //   lastOnlineTime: "lastOnlineTime",
            //   isOnline: true,
            //   hasDay: true,
            //   isBlock: false,
            // );
            int id = await _databaseController.insertUser(FriendListModel(
              name: _newChatName.text,
              imageUrl: _themeController.imageFile!.path,
              lastMessageTime: DateTime.now(),
              lastMessage: "hi",
              inactiveTime: DateFormat("h:mm a").format(DateTime.now()),
            ));

            _newChatName.clear();
            Navigator.pop(context);
          }
        },
      );

  KDialog _createGroupChatDialog(DatabaseController _databaseController) =>
      KDialog(
        name: "Create New Group",
        hintText: "Enter Group Name",
        btnText: "Create",
        newChatName: _newChatName,
        onPressed: () async {
          if (_newChatName.text != "") {
            int id = await _databaseController.insertUser(
              FriendListModel(
                name: _newChatName.text,
                imageUrl: _themeController.imageFile!.path,
                lastMessageTime: DateTime.now(),
                lastMessage: "hi",
                inactiveTime: DateFormat("h:mm a").format(DateTime.now()),
                hasGroup: true,
              ),
            );
            _newChatName.clear();
            Navigator.pop(context);
          }
        },
      );

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
                child: _themeController.imageFile == null
                    ? Image.asset(
                        'images/m1.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(_themeController.imageFile!.path),fit: BoxFit.cover,
                      ),

                // child: Image.asset(_themeController.profilePicPath.value,
                //     fit: BoxFit.cover),
              ),
            ),
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
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(customWidth(0.5)),
              borderSide: const BorderSide(color: Colors.transparent)),
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
            user: user,
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

  Widget _daySection(DatabaseController _databaseController) {
    return SizedBox(
      height: customWidth(.3),
      child: ListView(
        physics: const BouncingScrollPhysics(),
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
            _databaseController.userList.length,
            (index) => _daySingleWidget(_databaseController.userList[index]),
          ),
        ],
      ),
    );
  }
}
