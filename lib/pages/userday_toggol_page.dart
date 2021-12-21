import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/controller/user_controller.dart';
import 'package:fakeingbar/models/user.dart';
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
  final ThemeController _themeController = ThemeController();
  final UserController _userController = UserController();

  final List<User> _users = [];
  final List<bool> _dayUser = [];

  @override
  void initState() {
    super.initState();
    _users.addAll(_userController.users);
    _dayUser.addAll(_users.map((e) => e.hasDay).toList());
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
                  onPressed: () => Get.back(),
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
              users.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    CustomeCircleAvatar(
                      hasDay: users[index].hasDay,
                      imageUrl: users[index].imageUrl,
                      isOnline: users[index].isOnline,
                    ),
                    SizedBox(
                      width: customWidth(.02),
                    ),
                    Text(
                      users[index].name,
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
                        _userController.changeUserDay(users[index]);
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
