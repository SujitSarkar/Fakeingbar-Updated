import 'dart:io';

import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'custom_circle_avatar.dart';
import 'k_bottom_menu_button.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    Key? key,
    // required this.chatList,
    required this.index,
    required this.user,
  }) : super(key: key);

  final Rx<FriendListModel> user;
  final int index;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();

  List<String> menuItems = [
    "Edit",
    "Remove",
    "Delete",
    "Set Seen",
    "Set Received",
    "Set Not Received",
    "Set Not Send",
  ];

  final String removeStr = '@!remove^%\$#';

  final TextEditingController _editingController = TextEditingController();

  Rx<ChatListModel> chats = ChatListModel().obs;
  late int userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        chats.value = _databaseController.currentUserChats
            .firstWhere((element) => element.id == widget.index);
        userId = _databaseController.currentUser.value.id!;

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
                  _showBottomMenu(true);
                  _editingController.text = chats.value.sendMessage!;
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: chats.value.isReceived == "dateTime"
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: <Widget>[
                    chats.value.messageType == "dateTime"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              chats.value.sendMessage!,
                              textWidthBasis: TextWidthBasis.longestLine,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _themeController.darkenTextColor,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          )
                        : chats.value.sendMessage! == removeStr
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
                            : chats.value.messageType == "voice"
                                ? Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.all(customWidth(.02)),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: SThemeData.chatColors[
                                              widget.user.value.chatColor!],
                                        ),
                                        child: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: customWidth(.02),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          width: customWidth(.6),
                                          padding: EdgeInsets.symmetric(
                                            vertical: customWidth(.02),
                                            horizontal: customWidth(.02),
                                          ),
                                          decoration: BoxDecoration(
                                            color: SThemeData.chatColors[
                                                widget.user.value.chatColor!],
                                            borderRadius: BorderRadius.circular(
                                              customWidth(.04),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: customWidth(.03),
                                              ),
                                              SvgPicture.asset(
                                                "assets/svg/triangle.svg",
                                                fit: BoxFit.scaleDown,
                                                height: 20,
                                                width: 20,
                                                color: Colors.grey.shade300,
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                "assets/svg/sound_bar.svg",
                                                fit: BoxFit.scaleDown,
                                                height: 30,
                                                width: 70,
                                                color: Colors.white,
                                              ),
                                              const Spacer(),
                                              Text(
                                                chats.value.sendMessage!,
                                                textWidthBasis:
                                                    TextWidthBasis.longestLine,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                width: customWidth(.03),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : chats.value.messageType == "image"
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                            width: customWidth(.6),
                                            padding: EdgeInsets.symmetric(
                                              vertical: customWidth(.02),
                                              horizontal: customWidth(.02),
                                            ),
                                            decoration: BoxDecoration(
                                              color: SThemeData.chatColors[
                                                  widget.user.value.chatColor!],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                customWidth(.04),
                                              ),
                                            ),
                                            child: Image.file(File(
                                                chats.value.sendMessage!))),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                          vertical: customWidth(.025),
                                          horizontal: customWidth(.04),
                                        ),
                                        decoration: BoxDecoration(
                                          color: SThemeData.chatColors[
                                              widget.user.value.chatColor!],
                                          borderRadius: BorderRadius.circular(
                                              customWidth(.08)),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: customWidth(.5)),
                                          child: Text(
                                            chats.value.sendMessage!,
                                            textWidthBasis:
                                                TextWidthBasis.longestLine,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: _themeController.textColor,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ),
                    const SizedBox(width: 12.0),
                    chats.value.isReceived == "not send"
                        ? Icon(
                            Icons.circle_outlined,
                            color: SThemeData
                                .chatColors[widget.user.value.chatColor!],
                            size: customWidth(.05),
                          )
                        : chats.value.isReceived == "not received"
                            ? Icon(
                                Icons.check_circle_outline,
                                color: _themeController.darkenTextColor,
                                size: customWidth(.05),
                              )
                            : chats.value.isReceived == "received"
                                ? Icon(
                                    Icons.check_circle,
                                    color: _themeController.darkenTextColor,
                                    size: customWidth(.05),
                                  )
                                : chats.value.isReceived == "seen"
                                    ? SizedBox(
                                        width: customWidth(.04),
                                        height: customWidth(.04),
                                        child: CustomeCircleAvatar(
                                          user: widget.user.value,
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
                  _showBottomMenu(false);
                  _editingController.text = chats.value.receiveMessage!;
                },
                child: chats.value.messageType != "text"
                    ? const SizedBox()
                    : Row(
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
                              user: widget.user.value,
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          chats.value.receiveMessage! == removeStr
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
                                    constraints: BoxConstraints(
                                        maxWidth: customWidth(.5)),
                                    child: Text(
                                      "message was removed",
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              _themeController.darkenTextColor,
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
                                    constraints: BoxConstraints(
                                        maxWidth: customWidth(.5)),
                                    child: Text(
                                      chats.value.receiveMessage!,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
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

  _showBottomMenu(bool isSender) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return GetBuilder<DatabaseController>(
          builder: (_databaseController) {
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
                    chats.value.sendMessage != removeStr
                        ? KBottomManuButton(
                            menuItems: menuItems[0],
                            onPressed: () async {
                              Navigator.pop(context);
                              await _showEditDilog(isSender: isSender);

                              debugPrint(" Edit.............");
                            },
                          )
                        : const SizedBox(),
                    KBottomManuButton(
                      menuItems: menuItems[1],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            isSender
                                ? chats.value.copyWith(
                                    sendMessage: removeStr,
                                    isReceived: removeStr)
                                : chats.value.copyWith(
                                    receiveMessage: removeStr,
                                    isReceived: removeStr),
                            chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Remove Message.............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[2],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.deleteChat(chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Delete.............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[3],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chats.value.copyWith(isReceived: "seen"),
                            chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Set Seen............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[4],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chats.value.copyWith(isReceived: "received"),
                            chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Set Received..............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[5],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chats.value.copyWith(isReceived: "not received"),
                            chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Not Received...............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[6],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chats.value.copyWith(isReceived: "not send"),
                            chats.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Not Send...............");
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      elevation: 8.0,
    );
  }

  _showEditDilog({required bool isSender}) {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<DatabaseController>(
        builder: (_databaseController) {
          _editingController.text =
              isSender ? chats.value.sendMessage! : chats.value.isReceived!;
          return Dialog(
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(15),
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
                      onPressed: () async {
                        await _databaseController.updateChat(
                          isSender
                              ? chats.value.copyWith(
                                  sendMessage: _editingController.text)
                              : chats.value.copyWith(
                                  receiveMessage: _editingController.text),
                          widget.index,
                        );
                        _databaseController.updateCurrentUser(userId);
                        _editingController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
