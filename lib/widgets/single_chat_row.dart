import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/friend_list.dart';
import 'package:fakeingbar/pages/chat.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'custom_circle_avatar.dart';

class SingleChatRow extends StatefulWidget {
  const SingleChatRow({Key? key, required this.user}) : super(key: key);

  final FriendList user;

  @override
  _SingleChatRowState createState() => _SingleChatRowState();
}

class _SingleChatRowState extends State<SingleChatRow> {
  final ThemeController _themeController = Get.find();
  LongPressDownDetails _pressDetails = LongPressDownDetails();

  List<String> menuItems = [];
  @override
  void initState() {
    menuItems = [
      "Delete",
      "Set Seen",
      "Set Received",
      "Not Received",
      "Not Send",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: customWidth(.05),
        right: customWidth(.05),
        bottom: customWidth(0.05),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => Chat(
                user: widget.user,
              ));
        },
        onLongPressDown: (pressDetails) {
          setState(() {
            _pressDetails = pressDetails;
          });
        },
        onLongPress: () {
          _showPopupMenu(_pressDetails.globalPosition);
        },
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Row(
            children: <Widget>[
              CustomeCircleAvatar(
                hasDay: widget.user.hasDay,
                imageUrl: widget.user.imageUrl,
                isOnline: widget.user.isOnline,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.user.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _themeController.darkenTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: customWidth(.02),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        widget.user.lastMessage,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: customWidth(.01),
                      ),
                      const Text(
                        "\u00B7",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: customWidth(.01),
                      ),
                      Text(
                        widget.user.inactiveTime,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              widget.user.messageStatus == "not send"
                  ? Icon(
                      Icons.circle,
                      color: SThemeData.lightThemeColor,
                      size: customWidth(.05),
                    )
                  : widget.user.messageStatus == "not received"
                      ? Icon(
                          Icons.check_circle_outline,
                          color: _themeController.darkenTextColor,
                          size: customWidth(.05),
                        )
                      : widget.user.messageStatus == "received"
                          ? Icon(
                              Icons.check_circle,
                              color: _themeController.darkenTextColor,
                              size: customWidth(.05),
                            )
                          : widget.user.messageStatus == "seen"
                              ? SizedBox(
                                  width: customWidth(.05),
                                  height: customWidth(.05),
                                  child: CustomeCircleAvatar(
                                    imageUrl: widget.user.imageUrl,
                                    hasDay: false,
                                    isOnline: false,
                                  ),
                                )
                              : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  _showPopupMenu(Offset offset) async {
    RenderBox? overlay =
        Overlay.of(context)!.context.findRenderObject()! as RenderBox?;
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        top,
        overlay!.size.width - left,
        overlay.size.height - top,
      ),
      items: [
        // ...List.generate(
        //     5,
        //     (index) => PopupMenuItem(
        //           child: Text(menuItems[index]),
        //           value: index,
        //           onTap: () => print(index),
        //         ))
        PopupMenuItem(
          child: Text(menuItems[0]),
          onTap: () => _menuIndexedFunction(0),
        ),
        PopupMenuItem(
          child: Text(menuItems[1]),
          onTap: () => _menuIndexedFunction(1),
        ),
        PopupMenuItem(
          child: Text(menuItems[2]),
          onTap: () => _menuIndexedFunction(2),
        ),
        PopupMenuItem(
          child: Text(menuItems[3]),
          onTap: () => _menuIndexedFunction(3),
        ),
        PopupMenuItem(
          child: Text(menuItems[4]),
          onTap: () => _menuIndexedFunction(4),
        ),
      ],
      elevation: 8.0,
    );
  }

  _menuIndexedFunction(int item) {
    switch (item) {
      case 0:
        print("$item Delete.............");
        break;
      case 1:
        print("$item Set Seen............");
        break;
      case 2:
        print("$item Set Received..............");
        break;
      case 3:
        print("$item Not Received...............");
        break;
      case 4:
        print("$item Not Send...............");
        break;
      default:
    }
  }
}
