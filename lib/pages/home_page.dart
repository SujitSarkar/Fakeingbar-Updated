import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/pages/chat.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Chats",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: customWidth(.065),
      //     ),
      //   ),
      //   //backgroundColor: Colors.white,
      //   leading: InkWell(
      //     onTap: () => Navigator.pushNamed(context, '/profile'),
      //     child: Padding(
      //       padding: EdgeInsets.only(
      //           top: customWidth(.023),
      //           left: customWidth(.045),
      //           bottom: customWidth(.023)),
      //       child: CircleAvatar(
      //         backgroundImage: AssetImage("images/m1.jpg"),
      //         radius: 25.0,
      //       ),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Row(
      //         children: <Widget>[
      //           // CircleAvatar(
      //           //   backgroundColor: _themeController.backgroundColor,
      //           //   child: const Icon(
      //           //     Icons.camera_alt,
      //           //     color: Colors.black,
      //           //     size: 20,
      //           //   ),
      //           // ),
      //           Container(
      //             padding: EdgeInsets.all(customWidth(.018)),
      //             decoration: BoxDecoration(
      //               color: _themeController.backgroundColor,
      //               borderRadius: BorderRadius.circular(customWidth(.06)),
      //             ),
      //             child: const Icon(
      //               Icons.camera_alt,
      //               size: 20,
      //             ),
      //           ),
      //           SizedBox(width: MediaQuery.of(context).size.width * .035),
      //           Container(
      //             padding: EdgeInsets.all(customWidth(.018)),
      //             decoration: BoxDecoration(
      //               color: _themeController.backgroundColor,
      //               borderRadius: BorderRadius.circular(customWidth(.06)),
      //             ),
      //             child: const Icon(
      //               Icons.edit,
      //               size: 20,
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _appbarSection(context),
            _searchSection(),
            _daySection(),
            CircleProfs(
              "Ankur",
              "images/m2.jpg",
              "Lets meet tomorrow",
              " . 3:09 PM",
              true,
            ),
            CircleProfs(
              "Stella",
              "images/w2.jpg",
              "Hey What's up?",
              " . Wed",
              true,
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
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        iconSize: MediaQuery.of(context).size.width * .07,
        //onTap: ,
        elevation: 5
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
          onTap: () => Navigator.pushNamed(context, '/profile'),
          child: Padding(
            padding: EdgeInsets.only(
              top: customWidth(.03),
              left: customWidth(.05),
              bottom: customWidth(.03),
              right: customWidth(.05),
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/m1.jpg"),
              radius: customWidth(.05),
            ),
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

  _daySingleWidget(String name, String imgUrl, bool isOnline) {
    return Container(
      width: customWidth(.2),
      padding: EdgeInsets.symmetric(horizontal: customWidth(.025)),
      // decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: <Widget>[
          CustomeCircleAvatar(
            name: name,
            imgUrl: imgUrl,
            isOnline: isOnline,
          ),
          Container(
            child: Text(
              name,
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
        children: <Widget>[
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
          _daySingleWidget("Evan hossain", "images/w1.jpg", true),
          _daySingleWidget("Stella", "images/w2.jpg", true),
          _daySingleWidget("Rosy", "images/w1.jpg", true),
          _daySingleWidget("Ani", "images/w2.jpg", false),
          _daySingleWidget("Gabriela", "images/w1.jpg", true),
          _daySingleWidget("Marsh", "images/w2.jpg", false),
          _daySingleWidget("Rudolf", "images/w1.jpg", true),
          _daySingleWidget("Shaun", "images/w1.jpg", false),
          _daySingleWidget("Jason", "images/w1.jpg", true)
        ],
      ),
    );
  }

  CircleProfs(
      String name, String imgUrl, String msg, String time, bool isOnline) {
    return Padding(
      padding: EdgeInsets.only(
        left: customWidth(.05),
        right: customWidth(.05),
        bottom: customWidth(0.05),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => Chat(name, imgUrl, isOnline));
        },
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Row(
            children: <Widget>[
              CustomeCircleAvatar(
                name: name,
                imgUrl: imgUrl,
                isOnline: isOnline,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
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
                        msg,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        time,
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
}
