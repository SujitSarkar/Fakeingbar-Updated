import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/models/user.dart';
import 'package:fakeingbar/pages/chat.dart';
import 'package:fakeingbar/pages/profile_page.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeController _themeController = Get.find();

  final List<User> _users = [];

  late List<String> menuItems;

  LongPressDownDetails? _pressDetails;

  @override
  void initState() {
    menuItems = [
      "Delete",
      "Set Seen",
      "Set Received",
      "Not Received",
      "Not Send",
    ];
    _users.addAll(users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _appbarSection(context),
            _searchSection(),
            _daySection(),
            // singleChatRow(
            //   "Ankur",
            //   "images/m2.jpg",
            //   "Lets meet tomorrow",
            //   " . 3:09 PM",
            //   true,
            //   true,
            // ),
            // singleChatRow(
            //   "Stella",
            //   "images/w2.jpg",
            //   "Hey What's up?",
            //   " . Wed",
            //   true,
            //   false,
            // ),
            ListView(
              shrinkWrap: true,
              children: [
                ...List.generate(
                    _users.length, (index) => singleChatRow(users[index]))
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _themeController.toggleThemeData(),
                child: const Text('Change Theme'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(context),
    );
  }

  BottomNavigationBar _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: _themeController.scaffoldBackgroundColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.solidComment,
            size: 21,
          ),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            size: 30,
          ),
          label: 'People',
        ),
      ],

      currentIndex: 0,
      iconSize: MediaQuery.of(context).size.width * .07,
      //onTap: ,
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[
      //     IconButton(
      //         icon: Icon(
      //           Icons.chat,
      //           size: 25.0,
      //         ),
      //         onPressed: () {}
      //     ),
      //     SizedBox(
      //       width: 40.0,
      //     ),
      //     IconButton(
      //         icon: Icon(
      //           Icons.people,
      //           //color: Colors.grey,
      //           size: 30.0,
      //         ),
      //         onPressed: () {Navigator.pushNamed(context, '/people');}),
      //   ],
      // ),
    );
  }

  Row _appbarSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.to(() => ProfilePage()),
          child: Padding(
            padding: EdgeInsets.only(
              top: customWidth(.03),
              left: customWidth(.05),
              bottom: customWidth(.03),
              right: customWidth(.05),
            ),
            child: Container(
                width: customWidth(.16),
                height: customWidth(.16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _themeController.scaffoldBackgroundColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  // child: _themeController.imageFile != null
                  //     ? Image.file(
                  //         _themeController.imageFile!,
                  //         fit: BoxFit.cover,
                  //       )
                  //     : _themeController.pref!.getString("profilePicPath") !=
                  //             null
                  //         ? Image.asset(
                  //             _themeController.pref!
                  //                 .getString("profilePicPath")!,
                  //             fit: BoxFit.cover)
                  //         : Image.asset(
                  //             'images/m1.jpg',
                  //             fit: BoxFit.cover,
                  //           ),
                  child: Image.asset(_themeController.profilePicPath.value,
                      fit: BoxFit.cover),
                )),
          ),
        ),
        Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: customWidth(.065),
            color: _themeController.textColor,
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.all(customWidth(.026)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(customWidth(.018)),
                decoration: BoxDecoration(
                  color: _themeController.backgroundColor,
                  borderRadius: BorderRadius.circular(customWidth(.06)),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: _themeController.textColor,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .035),
              Container(
                padding: EdgeInsets.all(customWidth(.018)),
                decoration: BoxDecoration(
                  color: _themeController.backgroundColor,
                  borderRadius: BorderRadius.circular(customWidth(.06)),
                ),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: _themeController.textColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _searchSection() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: customWidth(.04),
        vertical: customWidth(.03),
      ),
      height: customWidth(.12),
      child: TextField(
        strutStyle: const StrutStyle(),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            color: _themeController.darkenTextColor,
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            color: _themeController.darkenTextColor,
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(customWidth(0.5)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(customWidth(0.5)),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }

  _daySingleWidget(User user) {
    return Container(
      width: customWidth(.2),
      height: customWidth(.3),
      padding: EdgeInsets.symmetric(horizontal: customWidth(.025)),
      // decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: <Widget>[
          CustomeCircleAvatar(
            hasDay: user.hasDay,
            imageUrl: user.imageUrl,
            isOnline: user.isOnline,
          ),
          Container(
            child: Text(
              user.name,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _themeController.textColor,
                  fontSize: customWidth(.036)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _daySection() {
    return SizedBox(
      height: customWidth(.3),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: customWidth(.025),
          ),
          Container(
            width: customWidth(.2),
            padding: EdgeInsets.symmetric(horizontal: customWidth(.025)),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: customWidth(.08),
                  child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.video_call,
                            color: _themeController.isLite.value
                                ? Colors.black
                                : Colors.white,
                            size: customWidth(.08),
                          ),
                          onPressed: () {})),
                  backgroundColor: _themeController.backgroundColor,
                ),
                Text(
                  "Create room",
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _themeController.textColor,
                    fontSize: customWidth(.036),
                  ),
                )
              ],
            ),
          ),
          ...List.generate(
              users.length, (index) => _daySingleWidget(users[index])),
        ],
      ),
    );
  }

  singleChatRow(User user) {
    return Padding(
      padding: EdgeInsets.only(
        left: customWidth(.05),
        right: customWidth(.05),
        bottom: customWidth(0.05),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => Chat(
                user: user,
              ));
        },
        onLongPressDown: (pressDetails) {
          setState(() {
            _pressDetails = pressDetails;
          });
        },
        onLongPress: () {
          _showPopupMenu(_pressDetails!.globalPosition);
        },
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Row(
            children: <Widget>[
              CustomeCircleAvatar(
                hasDay: user.hasDay,
                imageUrl: user.imageUrl,
                isOnline: user.isOnline,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _themeController.darkenTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        user.msg,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        user.lastOnlineTime,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
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
