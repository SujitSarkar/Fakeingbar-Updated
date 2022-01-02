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
  ChatSettingsPage({Key? key, required this.user}) : super(key: key);
  final FriendListModel user;

  @override
  State<ChatSettingsPage> createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();
  final TextEditingController _addMemberController = TextEditingController();

  final ThemeController _themeController = Get.find();

  int _radioSelected = 1;
  int _selectedChatColor = 0;

  @override
  void initState() {
    _selectedChatColor = widget.user.chatColor!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.user.name!;
    _activeController.text = _radioSelected == 1
        ? "Active Now"
        : widget.user.hasGroup!
            ? ""
            : "Active 2 hours ago";
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return Scaffold(
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
                            widget.user.hasGroup!
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
                    widget.user.hasGroup! ? KImagePicker() : const SizedBox(),
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
                    widget.user.hasGroup!
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
                      title:
                          Text(widget.user.hasGroup! ? "None" : "Active Ago"),
                      value: 2,
                      groupValue: _radioSelected,
                      activeColor: SThemeData.lightThemeColor,
                      onChanged: (value) {
                        setState(() {
                          _radioSelected = value!;
                        });
                      },
                    ),
                    widget.user.hasGroup!
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
                          widget.user.copyWith(
                            name: _nameController.text,
                            inactiveTime: _activeController.text,
                            chatColor: _selectedChatColor,
                          ),
                          widget.user.id!,
                        );
                        Get.back();
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
        );
      },
    );
  }

  Widget _addMemder(DatabaseController _databaseController) {
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
        ..._databaseController.groupUserList.value.map((group) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(group.imageUrl!)),
            ),
            title: Text(group.name!),
            trailing: Icon(
              Icons.edit,
              color: _themeController.darkenTextColor,
              size: customWidth(.05),
            ),
          );
        }),
        IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return KDialog(
                  databaseController: _databaseController,
                  newChatName: _addMemberController,
                  name: "Add Member",
                  hintText: "Member Name",
                  onPressed: () async {
                    await _databaseController.insertGroupUser(
                      GroupUserListModel(
                        friendListID: widget.user.id,
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
