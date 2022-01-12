import 'dart:async';
import 'dart:io';

import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/pages/video_call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class AudioCall extends StatefulWidget {
  final FriendListModel user;
  const AudioCall({Key? key, required this.user}) : super(key: key);

  @override
  _AudioCallState createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  final ThemeController _themeController = Get.find();

  final _count = 0.obs;

  String getDuration(int totalSeconds) {
    String seconds = (totalSeconds % 60).toInt().toString().padLeft(2, '0');
    String minutes =
        ((totalSeconds / 60) % 60).toInt().toString().padLeft(2, '0');
    String hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  Timer? _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _start++;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // countUp();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(builder: (_databaseController) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: FileImage(File(widget.user.imageUrl!)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Top Section
                      Column(
                        children: [
                          ///Appbar
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.white)),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff7B7F7E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: const Icon(
                                        Icons.videocam_off,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          ///Name image section
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 16.0, bottom: 8.0),
                            child: Container(
                              width: customWidth(.3),
                              height: customWidth(.3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: _themeController.scaffoldBackgroundColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _themeController.pref!
                                        .getString("profilePicPath")!
                                        .isNotEmpty
                                    ? Image.file(
                                        File(_themeController.pref!
                                            .getString("profilePicPath")!),
                                        fit: BoxFit.cover)
                                    : Image.asset(
                                        'images/m1.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                // child: Image.asset(_themeController.profilePicPath.value,
                                //     fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.user.name!,
                            style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getDuration(_start),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ],
                      ),

                      ///Bottom Section
                      Container(
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Color(0xff1D1F1C),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 6,
                                width: 35,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: const BoxDecoration(
                                    color: Color(0xff5E615D),
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
                                  child: const Icon(CupertinoIcons.volume_down,
                                      color: Colors.white, size: 28),
                                ),
                                const SizedBox(width: 20),
                                CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[600],
                                    child: const Icon(Icons.mic_sharp,
                                        color: Colors.white, size: 28)),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.redAccent,
                                      child: Icon(
                                          CupertinoIcons.phone_down_fill,
                                          color: Colors.white,
                                          size: 28)),
                                )
                              ],
                            ),
                            Container(
                              height: 6,
                              width: 35,
                              margin: const EdgeInsets.only(top: 10),
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
    });
  }
}
