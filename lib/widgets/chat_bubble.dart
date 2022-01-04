import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
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

  final String removeStr = '@!remove^%\$#';

  final TextEditingController _editingController = TextEditingController();
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
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        return Column(
          children: [
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 2.0,
              ),
              child: GestureDetector(
                onLongPress: () {
                  _showBottomMenu(_databaseController, true);
                  _editingController.text = widget.chatList.sendMessage!;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    widget.chatList.sendMessage! == removeStr
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: customWidth(.025),
                              horizontal: customWidth(.04),
                            ),
                            decoration: BoxDecoration(
                              color: _themeController.chatBGColor,
                              borderRadius: BorderRadius.circular(
                                customWidth(.1),
                              ),
                              border: Border.all(
                                color: _themeController.darkenTextColor!,
                              ),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: customWidth(.5)),
                              child: Text(
                                "message was removed",
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: _themeController.darkenTextColor,
                                    fontWeight: FontWeight.normal,
                                    height: 1.3,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: customWidth(.025),
                              horizontal: customWidth(.04),
                            ),
                            decoration: BoxDecoration(
                              color:
                                  SThemeData.chatColors[widget.user.chatColor!],
                              borderRadius:
                                  BorderRadius.circular(customWidth(.1)),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: customWidth(.5)),
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
                    widget.chatList.isReceived == "not send"
                        ? Icon(
                            Icons.circle_outlined,
                            color:
                                SThemeData.chatColors[widget.user.chatColor!],
                            size: customWidth(.05),
                          )
                        : widget.chatList.isReceived == "not received"
                            ? Icon(
                                Icons.check_circle_outline,
                                color: _themeController.darkenTextColor,
                                size: customWidth(.05),
                              )
                            : widget.chatList.isReceived == "received"
                                ? Icon(
                                    Icons.check_circle,
                                    color: _themeController.darkenTextColor,
                                    size: customWidth(.05),
                                  )
                                : widget.chatList.isReceived == "seen"
                                    ? SizedBox(
                                        width: customWidth(.04),
                                        height: customWidth(.04),
                                        child: CustomeCircleAvatar(
                                          user: widget.user,
                                          onlineDotSize: 0,
                                          showDay: false,
                                        ),
                                      )
                                    : const SizedBox(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 2.0,
              ),
              margin: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onLongPress: () {
                  _showBottomMenu(_databaseController, false);
                  _editingController.text = widget.chatList.receiveMessage!;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: customWidth(.07),
                      width: customWidth(.07),
                      child: CustomeCircleAvatar(
                        onlineDotSize: customWidth(.032),
                        borderWidth: 1.2,
                        showDay: false,
                        user: widget.user,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    widget.chatList.receiveMessage! == removeStr
                        ? Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: customWidth(.025),
                              horizontal: customWidth(.04),
                            ),
                            decoration: BoxDecoration(
                              color: _themeController.chatBGColor,
                              borderRadius:
                                  BorderRadius.circular(customWidth(.05)),
                              border: Border.all(
                                color: _themeController.darkenTextColor!,
                              ),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: customWidth(.5)),
                              child: Text(
                                "message was removed",
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: _themeController.darkenTextColor,
                                    fontWeight: FontWeight.normal,
                                    height: 1.3,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: customWidth(.025),
                              horizontal: customWidth(.04),
                            ),
                            decoration: BoxDecoration(
                              color: _themeController.chatBGColor,
                              borderRadius:
                                  BorderRadius.circular(customWidth(.05)),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: customWidth(.5)),
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
          ],
        );
      },
    );
  }

  _showBottomMenu(DatabaseController _databaseController, bool isSender) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          color: _themeController.isLite.isTrue
              ? const Color(0xff737373)
              : Colors.black,
          child: Container(
            decoration: BoxDecoration(
              color: _themeController.isLite.isFalse
                  ? const Color(0xff222222)
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
                      _menuIndexedFunction(
                        index,
                        _databaseController,
                        isSender,
                      );
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

  _menuIndexedFunction(
      int item, DatabaseController _databaseController, bool isSender) {
    switch (item) {
      case 0:
        _showEditDilog(_databaseController, isSender: isSender);
        print("$item Edit.............");
        break;
      case 1:
        _databaseController.updateChat(
            isSender
                ? widget.chatList.copyWith(sendMessage: removeStr)
                : widget.chatList.copyWith(receiveMessage: removeStr),
            widget.chatList.id!);
        print("$item Remove Message.............");
        break;
      case 2:
        _databaseController.deleteChat(widget.chatList.id!);
        print("$item Delete.............");
        break;
      case 3:
        _databaseController.updateChat(
            widget.chatList.copyWith(isReceived: "seen"), widget.chatList.id!);
        print("$item Set Seen............");
        break;
      case 4:
        _databaseController.updateChat(
            widget.chatList.copyWith(isReceived: "received"),
            widget.chatList.id!);
        print("$item Set Received..............");
        break;
      case 5:
        _databaseController.updateChat(
            widget.chatList.copyWith(isReceived: "not received"),
            widget.chatList.id!);
        print("$item Not Received...............");
        break;
      case 6:
        _databaseController.updateChat(
            widget.chatList.copyWith(isReceived: "not send"),
            widget.chatList.id!);
        print("$item Not Send...............");
        break;
      default:
    }
  }

  _showEditDilog(DatabaseController _databaseController,
      {required bool isSender}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: customWidth(.05)),
                  child: Text(
                    "Edit Message",
                    style: TextStyle(
                      color: _themeController.textColor,
                      fontSize: customWidth(.04),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _editingController,
                  decoration: const InputDecoration(
                    hintText: "Message",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _databaseController.updateChat(
                      isSender
                          ? widget.chatList
                              .copyWith(sendMessage: _editingController.text)
                          : widget.chatList.copyWith(
                              receiveMessage: _editingController.text),
                      widget.chatList.id!,
                    );
                    _editingController.clear();
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
