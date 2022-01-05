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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
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
                ..._databaseController.userList.map(
                  (user) => Container(
                    height: customWidth(0.2),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    margin: EdgeInsets.symmetric(vertical: customWidth(.01)),
                    child: Row(
                      // leading: CustomeCircleAvatar(
                      //   user: user,
                      // ),
                      // title: Text(
                      //   user.name!,
                      //   style: TextStyle(
                      //     color: _themeController.textColor,
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // trailing: Switch(
                      //   value: user.hasDay!,
                      //   onChanged: (value) {
                      //     // _userController.changeUserDay(_users[index]);
                      //     setState(() {
                      //       _databaseController.updateUser(
                      //           user.copyWith(hasDay: value), user.id!);
                      //     });
                      //     print(user.hasDay!);
                      //   },
                      // ),
                      children: [
                        SizedBox(
                          width: customWidth(.17),
                          height: customWidth(.17),
                          child: CustomeCircleAvatar(
                            user: user,
                          ),
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
      },
    );
  }
}
