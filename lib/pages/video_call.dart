import 'dart:io';

import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/data/sharedpreference/sharepreferenceController.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/widgets/k_circuler_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white)),
                          // KCirculerButton(
                          //   child: Icon(
                          //     Icons.person_add_rounded,
                          //     color: Colors.white,
                          //     size: 28,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 150,
                      width: 100,
                      margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                      child: _pref.getString(_pref.profilePicPath)!.isNotEmpty
                          ? Image.file(
                              File(_pref.getString(_pref.profilePicPath)!),
                              fit: BoxFit.cover)
                          : Image.asset(
                              'images/m1.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),

                    ///Bottom Section
                    Container(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[600],
                                child: const Icon(Icons.person_add_rounded,
                                    color: Colors.white, size: 28),
                              ),
                              const SizedBox(width: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[600],
                                child: const Icon(
                                    CupertinoIcons.camera_rotate_fill,
                                    color: Colors.white,
                                    size: 28),
                              ),
                              const SizedBox(width: 20),
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[600],
                                  child: const Icon(Icons.mic_sharp,
                                      color: Colors.white, size: 28)),
                              const SizedBox(width: 20),
                              const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(CupertinoIcons.phone_down_fill,
                                      color: Colors.white, size: 28))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
