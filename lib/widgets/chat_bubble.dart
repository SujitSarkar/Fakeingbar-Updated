import 'dart:io';

import 'package:dart_emoji/dart_emoji.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/models/gruop_user_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/jumping_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'custom_circle_avatar.dart';
import 'k_bottom_menu_button.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    Key? key,
    // required this.chatList,
    required this.chatId,
    required this.user,
    required this.chatIndex,
  }) : super(key: key);

  final Rx<FriendListModel> user;
  final int chatId;
  final int chatIndex;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final ThemeController _themeController = Get.find();

  bool isVisible = true;

  List<String> menuItems = [
    "Edit",
    "Remove",
    "Delete",
    "Set Seen",
    "Set Received",
    "Set Not Received",
    "Set Not Send",
  ];

  void timeDelay() {
    isVisible = false;
    Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  void initState() {
    // timeDelay();
    super.initState();
  }

  final String removeStr = '@!remove^%\$#';

  final TextEditingController _editingController = TextEditingController();

  Rx<ChatListModel> chat = ChatListModel().obs;
  late int userId;
  String? memberId;
  Rx<GroupUserListModel> member = GroupUserListModel().obs;
  List<GroupUserListModel> groupMembers = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        chat.value = _databaseController.currentUserChats
            .firstWhere((element) => element.id == widget.chatId);
        userId = _databaseController.currentUser.value.id!;
        memberId = chat.value.memberID!;
        if (widget.chatIndex == 0 && _databaseController.isNew.isTrue) {
          timeDelay();
          _databaseController.isNew.value = false;
        }
        if (_databaseController.currentUser.value.hasGroup!) {
          member.value = _databaseController.groupUserList
              .firstWhere((element) => element.id.toString() == memberId);
          groupMembers = _databaseController.groupUserList
              .where((g) =>
                  g.friendListID == _databaseController.currentUser.value.id!)
              .toList();
        }
        print("memberid:...................${memberId}");
        print("member:...................${member.value.name}");

        return Column(
          children: [
            //Send messgae
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: GestureDetector(
                onLongPress: () {
                  _showBottomMenu(true);
                  _editingController.text = chat.value.sendMessage!;
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: chat.value.messageType == "dateTime"
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //data time message
                        chat.value.messageType == "dateTime"
                            ? DateTimeMessage(
                                chat: chat, themeController: _themeController)
                            : chat.value.sendMessage! == removeStr
                                //remove message
                                ? RemoveMessage(
                                    themeController: _themeController)
                                //voice message
                                : chat.value.messageType == "voice"
                                    ? VoiceMessage(
                                        widget: widget,
                                        chat: chat,
                                        themeController: _themeController,
                                      )
                                    //image...
                                    : chat.value.messageType == "image"
                                        ? ImageMessage(
                                            themeController: _themeController,
                                            chat: chat,
                                          )
                                        //Text message
                                        : chat.value.messageType == "thumsUp"
                                            ? Icon(
                                                FontAwesomeIcons.solidThumbsUp,
                                                size: 32.0,
                                                color: SThemeData.chatColors[
                                                    widget
                                                        .user.value.chatColor!],
                                              )
                                            : TextMessage(
                                                widget: widget,
                                                message:
                                                    chat.value.sendMessage!,
                                                themeController:
                                                    _themeController,
                                                isReceive: false,
                                              ),
                        const SizedBox(width: 12.0),
                        widget.chatIndex == 0
                            ? chat.value.isReceived == "not send"
                                ? Icon(
                                    Icons.circle_outlined,
                                    color: SThemeData.chatColors[
                                        widget.user.value.chatColor!],
                                    size: customWidth(.05),
                                  )
                                : chat.value.isReceived == "not received"
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: _themeController.darkenTextColor,
                                        size: customWidth(.05),
                                      )
                                    : chat.value.isReceived == "received"
                                        ? Icon(
                                            Icons.check_circle,
                                            color: _themeController
                                                .darkenTextColor,
                                            size: customWidth(.05),
                                          )
                                        : chat.value.isReceived == "seen"
                                            ? widget.user.value.hasGroup!
                                                ? SizedBox(
                                                    width: customWidth(.05),
                                                  )
                                                : SizedBox(
                                                    width: customWidth(.04),
                                                    height: customWidth(.04),
                                                    child: CustomeCircleAvatar(
                                                      user: widget.user.value,
                                                      onlineDotSize: 0,
                                                      showDay: false,
                                                    ),
                                                  )
                                            : const SizedBox()
                            : SizedBox(
                                width: customWidth(.05),
                              ),
                        const SizedBox(
                            // height: customWidth(.052),
                            ),
                      ],
                    ),
                    widget.user.value.hasGroup! &&
                            widget.chatIndex == 0 &&
                            chat.value.isReceived == "seen"
                        ? _groupUserSeenWidget()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: customWidth(chat.value.messageType != "text" ? 0 : .05),
            ),

            //receive message
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: customWidth(.05),
              ),
              margin: const EdgeInsets.only(
                  // top: chat.value.messageType == "text" ? customWidth(.028) : 0,
                  ),
              child: GestureDetector(
                onLongPress: () {
                  _showBottomMenu(false);
                  _editingController.text = chat.value.receiveMessage!;
                },
                child: chat.value.messageType == "text"
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: customWidth(.07),
                            width: customWidth(.07),
                            child: widget.user.value.hasGroup!
                                ? CustomeCircleAvatar(
                                    onlineDotSize: customWidth(0),
                                    borderWidth: 1.2,
                                    showDay: false,
                                    user: widget.user.value,
                                    imageUrl: member.value.imageUrl,
                                  )
                                : CustomeCircleAvatar(
                                    onlineDotSize: customWidth(.032),
                                    borderWidth: 1.2,
                                    showDay: false,
                                    user: widget.user.value,
                                  ),
                          ),
                          const SizedBox(width: 15.0),
                          //Typing dot animation

                          Visibility(
                            visible: !isVisible,
                            child: Container(
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
                                  maxWidth: customWidth(.1),
                                  maxHeight: customWidth(.055),
                                ),
                                color: _themeController.chatBGColor,
                                child: const JumpingDots(),
                              ),
                            ),
                          ),
                          chat.value.receiveMessage! == removeStr
                              ? Visibility(
                                  visible: isVisible,
                                  child: RemoveMessage(
                                      themeController: _themeController),
                                )
                              : Visibility(
                                  visible: isVisible,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      widget.user.value.hasGroup!
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                left: customWidth(.04),
                                                bottom: customWidth(.008),
                                              ),
                                              child: Text(
                                                member.value.name!,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: customWidth(.035),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      TextMessage(
                                        widget: widget,
                                        message: chat.value.receiveMessage!,
                                        themeController: _themeController,
                                        isReceive: true,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )
                    : chat.value.messageType == "image"
                        ? const SizedBox()
                        : const SizedBox(),
              ),
            ),
            SizedBox(
              height:
                  customWidth(chat.value.messageType == "image" ? .01 : .05),
            ),
          ],
        );
      },
    );
  }

  Row _groupUserSeenWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...groupMembers.map(
          (e) => Container(
            width: customWidth(.045),
            height: customWidth(.05),
            padding: EdgeInsets.all(
              customWidth(.004),
            ),
            child: CustomeCircleAvatar(
              user: widget.user.value,
              onlineDotSize: 0,
              showDay: false,
              imageUrl: e.imageUrl,
            ),
          ),
        ),
        SizedBox(
          width: customWidth(.085),
        )
      ],
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
                    chat.value.sendMessage != removeStr
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
                                ? chat.value.copyWith(
                                    sendMessage: removeStr,
                                    isReceived: removeStr)
                                : chat.value.copyWith(
                                    receiveMessage: removeStr,
                                    isReceived: removeStr),
                            chat.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Remove Message.............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[2],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.deleteChat(chat.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Delete.............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[3],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chat.value.copyWith(isReceived: "seen"),
                            chat.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Set Seen............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[4],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chat.value.copyWith(isReceived: "received"),
                            chat.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Set Received..............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[5],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chat.value.copyWith(isReceived: "not received"),
                            chat.value.id!);
                        _databaseController.updateCurrentUser(userId);
                        debugPrint(" Not Received...............");
                      },
                    ),
                    KBottomManuButton(
                      menuItems: menuItems[6],
                      onPressed: () async {
                        Navigator.pop(context);
                        await _databaseController.updateChat(
                            chat.value.copyWith(isReceived: "not send"),
                            chat.value.id!);
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
              isSender ? chat.value.sendMessage! : chat.value.isReceived!;
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
                              ? chat.value.copyWith(
                                  sendMessage: _editingController.text)
                              : chat.value.copyWith(
                                  receiveMessage: _editingController.text),
                          widget.chatId,
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

class TextMessage extends StatelessWidget {
  TextMessage({
    Key? key,
    required this.widget,
    required this.message,
    required this.isReceive,
    required ThemeController themeController,
  })  : _themeController = themeController,
        super(key: key);

  final ChatBubble widget;
  final String message;
  final ThemeController _themeController;
  final bool isReceive;

  RxBool isEmoji = false.obs;

  bool isAllEmoji(String text) {
    for (String s in EmojiParser().unemojify(text).split(" ")) {
      if (!s.startsWith(":") || !s.endsWith(":")) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    isEmoji(isAllEmoji(message));
    print("isEmoji:   ${isEmoji.value}");
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: customWidth(.025),
        horizontal: customWidth(.04),
      ),
      decoration: BoxDecoration(
        color: isEmoji.isTrue
            ? Colors.transparent
            : isReceive
                ? _themeController.chatBGColor
                : SThemeData.chatColors[widget.user.value.chatColor!],
        borderRadius: BorderRadius.circular(customWidth(.045)),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: customWidth(.58)),
        child: Text(
          message,
          textWidthBasis: TextWidthBasis.longestLine,
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: isEmoji.isTrue ? 26 : 16.0,
            color: isReceive ? _themeController.textColor : Colors.white,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class VoiceMessage extends StatelessWidget {
  const VoiceMessage({
    Key? key,
    required ThemeController themeController,
    required this.widget,
    required this.chat,
  })  : _themeController = themeController,
        super(key: key);

  final ThemeController _themeController;
  final ChatBubble widget;
  final Rx<ChatListModel> chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(customWidth(.018)),
          decoration: BoxDecoration(
            color: _themeController.backgroundColor,
            borderRadius: BorderRadius.circular(customWidth(.06)),
          ),
          child: Icon(
            Icons.share,
            size: customWidth(.056),
            color: _themeController.textColor,
          ),
        ),
        SizedBox(
          width: customWidth(.02),
        ),
        Container(
          width: customWidth(.6),
          padding: EdgeInsets.symmetric(
            vertical: customWidth(.02),
            horizontal: customWidth(.02),
          ),
          decoration: BoxDecoration(
            color: SThemeData.chatColors[widget.user.value.chatColor!],
            borderRadius: BorderRadius.circular(
              customWidth(.04),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                chat.value.sendMessage!,
                textWidthBasis: TextWidthBasis.longestLine,
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
      ],
    );
  }
}

class RemoveMessage extends StatelessWidget {
  const RemoveMessage({
    Key? key,
    required ThemeController themeController,
  })  : _themeController = themeController,
        super(key: key);

  final ThemeController _themeController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        constraints: BoxConstraints(maxWidth: customWidth(.5)),
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
    );
  }
}

class DateTimeMessage extends StatelessWidget {
  const DateTimeMessage({
    Key? key,
    required this.chat,
    required ThemeController themeController,
  })  : _themeController = themeController,
        super(key: key);

  final Rx<ChatListModel> chat;
  final ThemeController _themeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: customWidth(.028),
      ),
      child: Text(
        chat.value.sendMessage!,
        textWidthBasis: TextWidthBasis.longestLine,
        style: TextStyle(
          fontSize: 14.0,
          color: _themeController.darkenTextColor,
        ),
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key? key,
    required ThemeController themeController,
    required this.chat,
  })  : _themeController = themeController,
        super(key: key);

  final ThemeController _themeController;
  final Rx<ChatListModel> chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Right Side Buttons
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(customWidth(.018)),
              decoration: BoxDecoration(
                color: _themeController.backgroundColor,
                borderRadius: BorderRadius.circular(customWidth(.06)),
              ),
              child: Icon(
                Icons.share,
                size: customWidth(.056),
                color: _themeController.textColor,
              ),
            ),
            SizedBox(
              height: customWidth(.05),
            ),
            Container(
              padding: EdgeInsets.all(customWidth(.018)),
              decoration: BoxDecoration(
                color: _themeController.backgroundColor,
                borderRadius: BorderRadius.circular(customWidth(.06)),
              ),
              child: Icon(
                Icons.camera_alt,
                size: customWidth(.056),
                color: _themeController.textColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: customWidth(.025),
        ),
        Container(
            // width: customWidth(.5),
            constraints: BoxConstraints(
              maxHeight: customWidth(.8),
              maxWidth: customWidth(.65),
            ),
            decoration: BoxDecoration(
              color: _themeController.backgroundColor,
              borderRadius: BorderRadius.circular(
                customWidth(.04),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.file(File(chat.value.sendMessage!))),
      ],
    );
  }
}
