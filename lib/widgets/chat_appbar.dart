import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/pages/audio_call_page.dart';
import 'package:fakeingbar/pages/chat_settings_page.dart';
import 'package:fakeingbar/pages/date_time_page.dart';
import 'package:fakeingbar/pages/video_call.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:fakeingbar/widgets/k_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChatAppBarAction extends StatelessWidget {
  final String title;
  final bool isOnline;
  final bool isBack;
  final String subTitle;
  final String imageUrl;
  final Color color;

  ChatAppBarAction({
    Key? key,
    required this.title,
    required this.isBack,
    required this.isOnline,
    required this.subTitle,
    required this.imageUrl,
    required this.color,
  }) : super(key: key);

  GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();
  final DatabaseController db = Get.find();

  List<String> bChatSetting = [
    "Block",
    "Set Profile Picture",
    "Add Date/Time",
    "Chat Settings",
  ];

  List<String> chatSetting = [
    "Unblock",
    "Set Profile Picture",
    "Add Date/Time",
    "Chat Settings",
  ];

  RxString block = "Block".obs;

  late RxBool isBlock = false.obs;
  late int userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(builder: (_databaseController) {
      userId = _databaseController.currentUser.value.id!;
      isBlock(_databaseController.currentUser.value.isBlock!);
      print("$isBlock");
      isBlock.isTrue ? block("Unblock") : block("Block");
      return Container(
        height: 90.0,
        padding: const EdgeInsets.only(right: 12.0, top: 25.0),
        decoration: BoxDecoration(
          color: _themeController.scaffoldBackgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context); //Routes.goBack(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.0,
                      color: color,
                    ),
                  ),
                ),
                Container(
                  width: 16.0,
                ),
                SizedBox(
                  height: customWidth(.11),
                  width: customWidth(.11),
                  child: CustomeCircleAvatar(
                    user: db.currentUser.value,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: _themeController.textColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Obx(() => Text(
                          isBlock.isFalse ? subTitle : "",
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 11.0),
                        ))
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () =>
                        _databaseController.currentUser.value.isBlock! == false
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => AudioCall(
                                        user: db.currentUser.value,
                                      ));
                                },
                                child: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: SThemeData.chatColors[
                                      _databaseController
                                          .currentUser.value.chatColor!],
                                  size: 20.0,
                                ),
                              )
                            : Container(
                                width: customWidth(.08),
                              ),
                  ),
                  SizedBox(
                    width: customWidth(.09),
                  ),
                  Obx(
                    () => isBlock.isFalse
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => VideoCallPage(
                                        user: _databaseController
                                            .currentUser.value,
                                      ));
                                },
                                child: Icon(
                                  FontAwesomeIcons.video,
                                  color: SThemeData.chatColors[
                                      _databaseController
                                          .currentUser.value.chatColor!],
                                  size: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .008,
                              ),
                              _databaseController.currentUser.value.isOnline ==
                                      false
                                  ? Container(
                                      width: 13.0,
                                      height: 13.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff4DC82C),
                                        border: Border.all(
                                          width: 3.0,
                                          color: _themeController
                                              .scaffoldBackgroundColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    )
                                  : const SizedBox(
                                      width: 13.0,
                                      height: 13.0,
                                    )
                            ],
                          )
                        : Container(
                            width: customWidth(.08),
                          ),
                  ),
                  SizedBox(
                    width: customWidth(.04),
                  ),
                  PopupMenuButton<int>(
                    key: _key,
                    itemBuilder: (context) {
                      return [
                        ...List.generate(
                          bChatSetting.length,
                          (index) => PopupMenuItem(
                            value: index,
                            child: Text(
                              isBlock.isTrue
                                  ? chatSetting[index]
                                  : bChatSetting[index],
                            ),
                          ),
                        )
                      ];
                    },
                    onSelected: (value) {
                      _menuIndexedFunction(context, value, _databaseController);
                    },
                    child: Icon(
                      Icons.info_rounded,
                      color: color,
                      size: 25.0,
                    ),
                  ),
                  SizedBox(
                    width: customWidth(.04),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  _menuIndexedFunction(BuildContext context, int item,
      DatabaseController _databaseController) async {
    switch (item) {
      case 0:
        int id = await _databaseController.updateUser(
          _databaseController.currentUser.value
              .copyWith(isBlock: isBlock == true ? false : true),
          userId,
        );
        _databaseController.updateCurrentUser(userId);
        print("$item Block.............$id");
        break;
      case 1:
        File? image = await _databaseController.pickImage();
        if (image != null) {
          await _databaseController.updateUser(
            _databaseController.currentUser.value
                .copyWith(imageUrl: image.path),
            userId,
          );
          _databaseController.updateCurrentUser(userId);
        }
        print("$item Set Profile Picture............");
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DateTimePage()));
        print("$item Add Date/Time..............");
        break;
      case 3:
        var result = await Get.to(() => const ChatSettingsPage());
        if (result == true) {
          // setState(() {
          //   widget.user = user;
          // });

        }
        print("$item Chat Settings...............$result");
        break;
      default:
    }
  }

  // _takeProfilePic() async {
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     setState(() {
  //       _chatListController.imageFile = File(image.path);
  //       _pref.setString(_pref.profilePicPath, image.path);
  //     });
  //   }
  // }
}
