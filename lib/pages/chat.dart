import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/widgets/chat_appbar.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../config.dart';

const listYourFriendChat = [
  'Nice to meet you!',
  'Hello',
];
const listYourChat = [
  'Nice to meet you!',
  'Hi',
];

class Chat extends StatefulWidget {
  final String name, image;
  final bool isOnline;
  const Chat(this.name, this.image, this.isOnline, {Key? key})
      : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _isScroll = true;

  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  // if (index != ListYourFriendChat.length - 1) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 2.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: customWidth(.08),
                              width: customWidth(.08),
                              child: CustomeCircleAvatar(
                                name: widget.name,
                                imgUrl: widget.image,
                                isOnline: widget.isOnline,
                                dotSize: customWidth(.032),
                                borderWidth: 2,
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
                                borderRadius:
                                    BorderRadius.circular(customWidth(.1)),
                              ),
                              child: Text(
                                listYourFriendChat[index],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _themeController.textColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 2.0,
                        ),
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
                                borderRadius:
                                    BorderRadius.circular(customWidth(.1)),
                              ),
                              child: Text(
                                listYourChat[index],
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
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
                      )
                    ],
                  );
                  //} else {
                  //return
                },
                itemCount: listYourFriendChat.length,
              ),
            ),
            _buildBottomChat(),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return ChatAppBarAction(
      isScroll: _isScroll,
      isBack: true,
      isOnline: widget.isOnline,
      title: widget.name, //widget.friendItem!.name,
      imageUrl: widget.image, //widget.friendItem!.imageAvatarUrl,
      subTitle: widget.isOnline == true ? 'Active now' : '10 hours ago',
      actions: <Widget>[
        InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return AudioCall(image:widget.image,name:widget.name,);  }));
          },
          child: const Icon(
            FontAwesomeIcons.phoneAlt,
            color: Colors.deepPurpleAccent,
            size: 20.0,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * .05),
        Row(
          children: [
            InkWell(
              // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>VideoCallPage(image:widget.image,name:widget.name))),
              child: const Icon(
                FontAwesomeIcons.video,
                color: Colors.deepPurpleAccent,
                size: 20.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .008,
            ),
            widget.isOnline == true
                ? Container(
                    width: 13.0,
                    height: 13.0,
                    decoration: BoxDecoration(
                        color: const Color(0xff4DC82C),
                        border: Border.all(
                          width: 3.0,
                          color: _themeController.scaffoldBackgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                  )
                : const SizedBox(
                    width: 13.0,
                    height: 13.0,
                  )
          ],
        ),
        const Icon(
          Icons.info_rounded,
          color: Colors.deepPurpleAccent,
          size: 25.0,
        ),
      ],
    );
  }

  _buildBottomChat() {
    return Container(
      decoration: BoxDecoration(
        color: _themeController.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 10),
      child: Row(
        children: <Widget>[
          Container(
            height: 20.0,
            width: 22.0,
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('images/noun_menu.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  FontAwesomeIcons.camera,
                  size: 20.0,
                  color: Colors.deepPurpleAccent,
                ),
                Icon(
                  CupertinoIcons.photo,
                  size: 20.0,
                  color: Colors.deepPurpleAccent,
                ),
                Icon(
                  CupertinoIcons.mic_solid,
                  size: 20.0,
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 50,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.width * .11,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'Aa',
                    filled: true,
                    hintStyle: TextStyle(
                      color: _themeController.darkenTextColor,
                    ),
                    suffixIcon: const Icon(
                      FontAwesomeIcons.solidSmileBeam,
                      size: 22.0,
                      color: Colors.deepPurpleAccent,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.solidThumbsUp,
                size: 22.0,
                color: Colors.deepPurpleAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarNetworkRoundedImage extends StatelessWidget {
  final String? imageUrl;
  const AppBarNetworkRoundedImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
