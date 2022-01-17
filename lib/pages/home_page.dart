import 'dart:io';

import 'package:device_screen_recorder/device_screen_recorder.dart';
import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/models/trainer_chat_model.dart';
import 'package:fakeingbar/pages/profile_page.dart';
import 'package:fakeingbar/pages/trainer_page.dart';
import 'package:fakeingbar/pages/userday_toggol_page.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/k_chat_dialog.dart';
import 'package:fakeingbar/widgets/k_dialog.dart';
import 'package:fakeingbar/widgets/k_trainer_dialog.dart';
import 'package:fakeingbar/widgets/single_chat_row.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();
  final KSharedPreference _pref = Get.find();
  final TextEditingController _newChatName = TextEditingController();
  final TextEditingController _sendMsgController = TextEditingController();
  final TextEditingController _replyMsgController = TextEditingController();
  // SharedPreferences? _pref1;
  // Future<void> initializeData() async {
  //   _pref1 = await SharedPreferences.getInstance();
  // }

  @override
  void initState() {
    // initializeData();
    super.initState();
  }

  bool recording = false;
  String path = '';

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
                    physics: const ClampingScrollPhysics(),
                    children: [
                      _searchSection(),
                      _daySection(_databaseController),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _themeController.toggleThemeData(),
                          child: const Text("Change Theme"),
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

  Future<void> stopRecording() async {
    var file = await DeviceScreenRecorder.stopRecordScreen();
    setState(() {
      path = file ?? '';
      recording = false;
    });
    Get.snackbar(
      "Recording Complete",
      "Recording save to $path",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      backgroundColor: _themeController.chatBGColor,
      borderColor: _themeController.backgroundColor,
      borderWidth: 1,
      dismissDirection: DismissDirection.up,
      icon: const Icon(Icons.video_collection),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  Future<void> startRecording() async {
    var status = await DeviceScreenRecorder.startRecordScreen();
    // var status = await ScreenRecorder.startRecordScreen(name: 'example');
    setState(() {
      recording = status ?? false;
    });
  }

  Row _appbarSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.to(() => const ProfilePage()),
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
                child: _pref.getString(_pref.profilePicPath).isNotEmpty
                    ? Image.file(File(_pref.getString(_pref.profilePicPath)),
                        fit: BoxFit.cover)
                    : Image.asset(
                        'images/m1.jpg',
                        fit: BoxFit.cover,
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
                child: GestureDetector(
                  onTap: () async {
                    recording ? await stopRecording() : await startRecording();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: _themeController.textColor,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .035),
              GestureDetector(
                onTap: () {
                  Get.to(() => TrainerPage());
                },
                child: Container(
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
