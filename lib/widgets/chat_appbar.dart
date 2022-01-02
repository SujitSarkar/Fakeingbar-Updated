import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/chatlist_controller.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/pages/audio_call_page.dart';
import 'package:fakeingbar/pages/chat_settings_page.dart';
import 'package:fakeingbar/pages/date_time_page.dart';
import 'package:fakeingbar/pages/video_call.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatAppBarAction extends StatefulWidget {
  final String title;
  final bool isScroll;
  final bool isOnline;
  final bool isBack;
  final String subTitle;
  final String imageUrl;
  final FriendListModel user;

  ChatAppBarAction({
    Key? key,
    this.title = '',
    required this.isScroll,
    required this.isBack,
    required this.isOnline,
    required this.subTitle,
    required this.imageUrl,
    required this.user,
  }) : super(key: key);

  @override
  _ChatAppBarActionState createState() => _ChatAppBarActionState();
}

class _ChatAppBarActionState extends State<ChatAppBarAction> {
  GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();
  final ChatListController _chatListController = Get.find();

  List<String> chatSetting = [];

  @override
  void initState() {
    chatSetting = [
      "Block",
      "Set Profile Picture",
      "Add Date/Time",
      "Chat Settings",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.only(right: 12.0, top: 25.0),
      decoration: BoxDecoration(
        color: _themeController.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: widget.isScroll ? Colors.black12 : Colors.white,
            offset: const Offset(0.0, 1.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context); //Routes.goBack(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 25.0,
                    color: SThemeData.chatColors[widget.user.chatColor!],
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
                  user: widget.user,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Text(
                      widget.user.name!,
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 3),
                  Obx(() => Text(
                        _chatListController.isUserBlocked.isFalse
                            ? widget.subTitle
                            : "",
                        style: TextStyle(color: Colors.grey, fontSize: 11.0),
                      ))
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => _chatListController.isUserBlocked.isFalse
                        ? InkWell(
                            onTap: () {
                              Get.to(() => AudioCall(
                                    name: widget.user.name,
                                    image: widget.user.imageUrl,
                                  ));
                            },
                            child: Icon(
                              FontAwesomeIcons.phoneAlt,
                              color:
                                  SThemeData.chatColors[widget.user.chatColor!],
                              size: 20.0,
                            ),
                          )
                        : Container(
                            width: customWidth(.08),
                          ),
                  ),
                  Obx(
                    () => _chatListController.isUserBlocked.isFalse
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => VideoCallPage(
                                        name: widget.user.name,
                                        image: widget.user.imageUrl,
                                      ));
                                },
                                child: Icon(
                                  FontAwesomeIcons.video,
                                  color: SThemeData
                                      .chatColors[widget.user.chatColor!],
                                  size: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .008,
                              ),
                              widget.user.isOnline == true
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
                                              BorderRadius.circular(15.0)),
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
                  PopupMenuButton<int>(
                    key: _key,
                    itemBuilder: (context) {
                      return [
                        ...List.generate(
                          chatSetting.length,
                          (index) => PopupMenuItem(
                            value: index,
                            child: Text(chatSetting[index]),
                          ),
                        )
                      ];
                    },
                    onSelected: (value) {
                      _menuIndexedFunction(value);
                    },
                    child: Icon(
                      Icons.info_rounded,
                      color: SThemeData.chatColors[widget.user.chatColor!],
                      size: 25.0,
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  _menuIndexedFunction(int item) {
    switch (item) {
      case 0:
        _chatListController.isUserBlocked.toggle();
        print("$item Block.............");
        break;
      case 1:
        _takeProfilePic();
        print("$item Set Profile Picture............");
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DateTimePage()));
        print("$item Add Date/Time..............");
        break;
      case 3:
        Get.to(() => ChatSettingsPage(
              user: widget.user,
            ));
        print("$item Chat Settings...............");
        break;
      default:
    }
  }

  _takeProfilePic() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _chatListController.imageFile = File(image.path);
        _themeController.pref!.setString("profilePicPath", image.path);
      });
    }
  }
}
