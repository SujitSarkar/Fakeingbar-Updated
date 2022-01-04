import 'dart:io';

import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/models/gruop_user_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/k_dialog.dart';
import 'package:fakeingbar/widgets/k_filled_button.dart';
import 'package:fakeingbar/widgets/k_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatSettingsPage> createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();
  final TextEditingController _addMemberController = TextEditingController();
  final DatabaseController db = Get.find();

  final ThemeController _themeController = Get.find();

  int _radioSelected = 1;
  int _selectedChatColor = 0;

  late FriendListModel user;

  @override
  void initState() {
    _selectedChatColor = db.currentUser.value.chatColor!;
    user = db.currentUser.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = user.name!;
    _activeController.text = _radioSelected == 1
        ? "Active Now"
        : user.hasGroup!
            ? ""
            : "Active 2 hours ago";
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        // _selectedChatColor = _databaseController.currentUser.value.chatColor!;
        debugPrint(
            "Current ID.........: ${_databaseController.currentUser.value.id!}");
        debugPrint("ID.....: ${user.id}");
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, false);
            return false;
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: SThemeData.blueDotColor,
                        padding: EdgeInsets.only(left: customWidth(.04)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _databaseController.currentUser.value.hasGroup!
                                  ? "Group Settings"
                                  : "Chat Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: customWidth(.06),
                                  color: _themeController.textColor),
                            ),
                            IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.close)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                      _databaseController.currentUser.value.hasGroup!
                          ? KImagePicker()
                          : const SizedBox(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Edit Name",
                          style: TextStyle(
                            color: _themeController.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: customWidth(.05),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: customWidth(.01),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                      _databaseController.currentUser.value.hasGroup!
                          ? _addMemder(_databaseController)
                          : const SizedBox(),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Online Status",
                          style: TextStyle(
                            color: _themeController.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: customWidth(.05),
                          ),
                        ),
                      ),
                      RadioListTile<int>(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Active"),
                        value: 1,
                        groupValue: _radioSelected,
                        activeColor: SThemeData.lightThemeColor,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                            _databaseController.currentUser.value.hasGroup!
                                ? "None"
                                : "Active Ago"),
                        value: 2,
                        groupValue: _radioSelected,
                        activeColor: SThemeData.lightThemeColor,
                        onChanged: (value) {
                          setState(() {
                            _radioSelected = value!;
                          });
                        },
                      ),
                      _databaseController.currentUser.value.hasGroup!
                          ? const SizedBox()
                          : TextField(
                              controller: _activeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Chat Color",
                          style: TextStyle(
                            color: _themeController.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: customWidth(.05),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: customWidth(.02),
                      ),
                      //List of Colors
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: customWidth(.025)),
                        child: Wrap(
                          children: [
                            ...List.generate(
                              SThemeData.chatColors.length,
                              (index) => GestureDetector(
                                onTap: () => setState(() {
                                  _selectedChatColor = index;
                                }),
                                child: Container(
                                  margin: EdgeInsets.all(customWidth(.016)),
                                  width: customWidth(.14),
                                  height: customWidth(.16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: SThemeData.chatColors[index],
                                  ),
                                  child: _selectedChatColor == index
                                      ? Icon(
                                          Icons.check,
                                          size: customWidth(.1),
                                          color: _themeController.textColor,
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                      KFilledButton(
                        text: "Save",
                        btnColor: SThemeData.blueDotColor,
                        onPressed: () {
                          _databaseController.updateUser(
                            user.copyWith(
                              name: _nameController.text.isEmpty
                                  ? _databaseController.currentUser.value.name
                                  : _nameController.text,
                              inactiveTime: _activeController.text.isEmpty
                                  ? _databaseController
                                      .currentUser.value.inactiveTime
                                  : _activeController.text,
                              chatColor: _selectedChatColor,
                              isOnline: _radioSelected == 1,
                            ),
                            user.id!,
                          );
                          debugPrint(
                              "Current ID.........: ${_databaseController.currentUser.value.id!}/nCurrent ID.........: ${_databaseController.currentUser.value.chatColor!}");
                          _databaseController.currentUser.value = user.copyWith(
                            name: _nameController.text.isEmpty
                                ? _databaseController.currentUser.value.name
                                : _nameController.text,
                            inactiveTime: _activeController.text.isEmpty
                                ? _databaseController
                                    .currentUser.value.inactiveTime
                                : _activeController.text,
                            chatColor: _selectedChatColor,
                            isOnline: _radioSelected == 1,
                          );
                          _databaseController.currentUser.value.id = user.id;
                          Navigator.pop(context, true);
                        },
                      ),
                      SizedBox(
                        height: customWidth(.05),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addMemder(DatabaseController _databaseController) {
    List<GroupUserListModel> groupMembers = _databaseController.groupUserList
        .where(
            (g) => g.friendListID == _databaseController.currentUser.value.id!)
        .toList();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Add Member",
            style: TextStyle(
              color: _themeController.textColor,
              fontWeight: FontWeight.w400,
              fontSize: customWidth(.05),
            ),
          ),
        ),
        groupMembers.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Add Group Members"),
              )
            : const SizedBox(),
        ...groupMembers.map((group) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(group.imageUrl!)),
            ),
            title: Text(group.name!),
            trailing: IconButton(
              icon: Icon(
                Icons.edit,
                color: _themeController.darkenTextColor,
                size: customWidth(.05),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  _addMemberController.text = group.name!;
                  return KDialog(
                    newChatName: _addMemberController,
                    name: "Edit Member",
                    hintText: "Member Name",
                    btnText: "Save",
                    onPressed: () async {
                      await _databaseController.updateGroupUser(
                        group.copyWith(
                          name: _addMemberController.text,
                          imageUrl: _themeController.imageFile == null
                              ? group.imageUrl
                              : _themeController.imageFile!.path,
                        ),
                        group.id!,
                      );
                      await _databaseController.getGroupUserList();
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        }),
        IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return KDialog(
                  newChatName: _addMemberController,
                  name: "Add Member",
                  hintText: "Member Name",
                  btnText: "Create",
                  onPressed: () async {
                    await _databaseController.insertGroupUser(
                      GroupUserListModel(
                        friendListID: _databaseController.currentUser.value.id,
                        name: _addMemberController.text,
                        imageUrl: _themeController.imageFile!.path,
                      ),
                    );
                    await _databaseController.getGroupUserList();
                  },
                );
              }),
          icon: const Icon(Icons.add_box),
        ),
      ],
    );
  }
}
