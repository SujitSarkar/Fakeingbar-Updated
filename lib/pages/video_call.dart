import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/widgets/k_circuler_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class VideoCallPage extends StatelessWidget {
  final FriendListModel user;
  VideoCallPage({Key? key, required this.user}) : super(key: key);
  final KSharedPreference _pref = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: FileImage(File(user.imageUrl!)),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: customWidth(0.05),
                      vertical: customWidth(0.025),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // IconButton(
                        //     onPressed: () => Navigator.pop(context),
                        //     icon: const Icon(Icons.arrow_back,
                        //         color: Colors.white)),
                        KCirculerButton(
                          child: Icon(
                            FontAwesomeIcons.solidComment,
                            size: customWidth(.065),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Spacer(),
                        KCirculerButton(
                          child: Icon(
                            CupertinoIcons.camera_rotate_fill,
                            size: customWidth(.065),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(
                          width: customWidth(.035),
                        ),
                        KCirculerButton(
                          child: Icon(
                            FontAwesomeIcons.video,
                            size: customWidth(.065),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 180,
                    width: 100,
                    margin: EdgeInsets.only(
                      right: customWidth(.05),
                      top: customWidth(.05),
                    ),
                    child: _pref.getString(_pref.profilePicPath)!.isNotEmpty
                        ? Image.file(
                            File(_pref.getString(_pref.profilePicPath)!),
                            fit: BoxFit.cover)
                        : Image.asset(
                            'images/m1.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: customWidth(.8),
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 6,
                            width: 35,
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 20,
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: customWidth(.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.all(customWidth(.008)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.5,
                                  ),
                                ),
                                child: Container(
                                  width: customWidth(.135),
                                  height: customWidth(.135),
                                  decoration: BoxDecoration(
                                    color: Colors.white12.withOpacity(.6),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              KCirculerButton(
                                child: Icon(
                                  Icons.person_add_rounded,
                                  color: Colors.white,
                                  size: customWidth(.095),
                                ),
                                size: 60,
                                onPressed: () {},
                              ),
                              KCirculerButton(
                                child: Icon(
                                  Icons.mic_sharp,
                                  color: Colors.white,
                                  size: customWidth(.095),
                                ),
                                size: 60,
                                onPressed: () {},
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.redAccent,
                                    child: Icon(CupertinoIcons.phone_down_fill,
                                        color: Colors.white, size: 28)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
