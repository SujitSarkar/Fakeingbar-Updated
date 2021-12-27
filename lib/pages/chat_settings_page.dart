import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/friend_list.dart';
import 'package:fakeingbar/variables/theme_data.dart';
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

  final ThemeController _themeController = Get.find();

  int _radioSelected = 1;
  int _selectedChatColor = 0;

  final List<Color> _chatColors = [
    Colors.blueAccent,
    Colors.cyan,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.indigoAccent,
    Colors.green,
    Colors.deepOrangeAccent,
    Colors.indigoAccent,
    Colors.limeAccent,
    Colors.pinkAccent,
  ];

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.user.name!;
    _activeController.text =
        _radioSelected == 1 ? "Active Now" : "Active 2 hours ago";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () => Get.back(), icon: Icon(Icons.close)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Edit Name",
                    style: TextStyle(
                      color: _themeController.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: customWidth(.05),
                    ),
                  ),
                  SizedBox(
                    height: customWidth(.01),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: customWidth(.05),
                  ),
                  Text(
                    "Online Status",
                    style: TextStyle(
                      color: _themeController.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: customWidth(.05),
                    ),
                  ),
                  RadioListTile<int>(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Active"),
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
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Active Age"),
                    value: 2,
                    groupValue: _radioSelected,
                    activeColor: SThemeData.lightThemeColor,
                    onChanged: (value) {
                      setState(() {
                        _radioSelected = value!;
                      });
                    },
                  ),
                  TextField(
                    controller: _activeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: customWidth(.05),
                  ),
                  Text("Select Chat Color"),
                  SizedBox(
                    height: customWidth(.02),
                  ),
                  Wrap(
                    children: [
                      ...List.generate(
                        _chatColors.length,
                        (index) => GestureDetector(
                          onTap: () => setState(() {
                            _selectedChatColor = index;
                          }),
                          child: Container(
                            margin: EdgeInsets.all(customWidth(.01)),
                            width: customWidth(.16),
                            height: customWidth(.16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _chatColors[index],
                            ),
                            child: _selectedChatColor == index
                                ? Icon(
                                    Icons.check,
                                    size: customWidth(.1),
                                    color: _themeController.darkenTextColor,
                                  )
                                : SizedBox(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: customWidth(.05),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                        primary: SThemeData.lightThemeColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
