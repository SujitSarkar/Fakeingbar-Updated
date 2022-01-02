import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/controller/friendList_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class UserDayToggolPage extends StatefulWidget {
  UserDayToggolPage({Key? key}) : super(key: key);

  @override
  State<UserDayToggolPage> createState() => _UserDayToggolPageState();
}

class _UserDayToggolPageState extends State<UserDayToggolPage> {
  final ThemeController _themeController = Get.find();
  final FriendListController _userController = Get.find();
  final DatabaseController _databaseController = Get.find();

  final List<FriendListModel> _users = [];
  final List<bool> _dayUser = [];

  @override
  void initState() {
    super.initState();
    _users.addAll(_databaseController.userList);
    _dayUser.addAll(_users.map((e) => e.hasDay!));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(builder: (_databaseController) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "All Users",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: customWidth(.05),
                      color: _themeController.textColor,
                    ),
                  ),
                ],
              ),
              ..._users.map(
                (user) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: Row(
                    children: [
                      CustomeCircleAvatar(
                        user: user,
                      ),
                      SizedBox(
                        width: customWidth(.02),
                      ),
                      Text(
                        user.name!,
                        style: TextStyle(
                          color: _themeController.textColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: user.hasDay!,
                        onChanged: (value) {
                          // _userController.changeUserDay(_users[index]);
                          setState(() {
                            _databaseController.updateUser(
                                user.copyWith(hasDay: value), user.id!);
                          });
                          print(user.hasDay!);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
