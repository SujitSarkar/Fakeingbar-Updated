import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/chat_list.dart';
import 'package:fakeingbar/models/friend_list.dart';
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

  final ChatListModel chatList;
  final FriendListModel user;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
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
      "Set Not Received",
      "Set Not Send",
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
          margin: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onLongPress: () => _showBottomMenu(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: customWidth(.08),
                  width: customWidth(.08),
                  child: CustomeCircleAvatar(
                    onlineDotSize: customWidth(.032),
                    borderWidth: 2,
                  user: widget.user,
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
                      widget.chatList.receiveMessage!,
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
            onLongPress: () => _showBottomMenu(),
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
                  child: Container(
                    constraints: BoxConstraints(maxWidth: customWidth(.5)),
                    child: Text(
                      widget.chatList.sendMessage!,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
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

  _showBottomMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          color:
              _themeController.isLite.isTrue ? Color(0xff737373) : Colors.black,
          child: Container(
            decoration: BoxDecoration(
              color: _themeController.isLite.isFalse
                  ? Color(0xff222222)
                  : _themeController.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(customWidth(.05)),
                topRight: Radius.circular(
                  customWidth(.05),
                ),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...List.generate(
                  menuItems.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _menuIndexedFunction(index);
                    },
                    child: Container(
                      height: customWidth(.15),
                      width: customWidth(.2),
                      padding: EdgeInsets.all(customWidth(.015)),
                      margin: EdgeInsets.symmetric(
                          horizontal: customWidth(.01),
                          vertical: customWidth(.02)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _themeController.chatBGColor,
                        borderRadius: BorderRadius.circular(customWidth(.05)),
                      ),
                      child: Text(
                        menuItems[index],
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      elevation: 8.0,
    );
  }

  _menuIndexedFunction(int item) {
    switch (item) {
      case 0:
        _showEditDilog();
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

  _showEditDilog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
