import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/controller/friendList_controller.dart';
import 'package:fakeingbar/models/friend_list.dart';
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

  final List<FriendListModel> _users = [];
  final List<bool> _dayUser = [];

  @override
  void initState() {
    super.initState();
    _users.addAll(_userController.users);
    _dayUser.addAll(_users.map((e) => e.hasDay!));
  }

  @override
  Widget build(BuildContext context) {
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
                  "All Active Users",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: customWidth(.05),
                    color: _themeController.textColor,
                  ),
                ),
              ],
            ),
            ...List.generate(
              _users.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    CustomeCircleAvatar(
                      hasDay: _users[index].hasDay!,
                      imageUrl: _users[index].imageUrl!,
                      isOnline: _users[index].isOnline!,
                    ),
                    SizedBox(
                      width: customWidth(.02),
                    ),
                    Text(
                      _users[index].name!,
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: _dayUser[index],
                      onChanged: (value) {
                        _userController.changeUserDay(_users[index]);
                        _dayUser[index] = !_dayUser[index];
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
