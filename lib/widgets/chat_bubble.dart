import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'custom_circle_avatar.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    Key? key,
    required this.chatList,
    required this.user,
  }) : super(key: key);

  final ChatList chatList;
  final User user;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final ThemeController _themeController = Get.find();

  List<String> menuItems = [];

  LongPressDownDetails? _pressDetails;

  @override
  void initState() {
    menuItems = [
      "Edit",
      "Remove Message",
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 2.0,
          ),
          child: GestureDetector(
            onLongPress: () => _showPopupMenu(_pressDetails!.globalPosition),
            onLongPressDown: (details) {
              setState(() {
                _pressDetails = details;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: customWidth(.08),
                  width: customWidth(.08),
                  child: CustomeCircleAvatar(
                    dotSize: customWidth(.032),
                    borderWidth: 2,
                    isOnline: widget.user.isOnline,
                    hasDay: widget.user.hasDay,
                    imageUrl: widget.user.imageUrl,
                  ),
                ),
                const SizedBox(width: 15.0),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: customWidth(.025),
                    horizontal: customWidth(.04),
                  ),
                  decoration: BoxDecoration(
                    color: _themeController.chatBGColor,
                    borderRadius: BorderRadius.circular(customWidth(.05)),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: customWidth(.5)),
                    child: Text(
                      widget.chatList.receiveMessage,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 2.0,
          ),
          child: GestureDetector(
            onLongPress: () => _showPopupMenu(_pressDetails!.globalPosition),
            onLongPressDown: (details) {
              setState(() {
                _pressDetails = details;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: customWidth(.025),
                    horizontal: customWidth(.04),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(customWidth(.1)),
                  ),
                  child: Text(
                    widget.chatList.sendMessage,
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: _themeController.textColor,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                // SizedBox(
                //   height: customWidth(.08),
                //   width: customWidth(.08),
                //   child: CustomeCircleAvatar(
                //     name: widget.name,
                //     imgUrl: widget.image,
                //     isOnline: widget.isOnline,
                //     dotSize: customWidth(.032),
                //     borderWidth: 2,
                //   ),
                // )
              ],
            ),
          ),
        )
      ],
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
        PopupMenuItem(
          child: Text(menuItems[5]),
          onTap: () => _menuIndexedFunction(5),
        ),
        PopupMenuItem(
          child: Text(menuItems[6]),
          onTap: () => _menuIndexedFunction(6),
        ),
      ],
      elevation: 8.0,
    );
  }

  _menuIndexedFunction(int item) {
    switch (item) {
      case 0:
        print("$item Edit.............");
        break;
      case 1:
        print("$item Remove Message.............");
        break;
      case 2:
        print("$item Delete.............");
        break;
      case 3:
        print("$item Set Seen............");
        break;
      case 4:
        print("$item Set Received..............");
        break;
      case 5:
        print("$item Not Received...............");
        break;
      case 6:
        print("$item Not Send...............");
        break;
      default:
    }
  }
}
