import 'dart:io';

import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: customWidth(1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: customWidth(.065),
                  color: _themeController.textColor,
                ),
              ),
              SizedBox(
                height: customWidth(0.1),
              ),
              GestureDetector(
                onTap: () async {
                  ImagePicker _picker = ImagePicker();
                  await _picker
                      .pickImage(source: ImageSource.gallery)
                      .then((xFile) {
                    if (xFile != null) {
                      setState(() {
                        _themeController.imageFile = File(xFile.path);
                      });
                      _themeController.pref!
                          .setString("profilePicPath", xFile.path);
                    }
                  });
                },
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _themeController.scaffoldBackgroundColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _themeController.imageFile == null
                          ? Image.asset(
                              _themeController.pref!
                                  .getString("profilePicPath")!,
                              fit: BoxFit.cover)
                          : Image.file(
                              _themeController.imageFile!,
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
              SizedBox(
                height: customWidth(0.05),
              ),
              Text(
                "Change Profile Picture",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: customWidth(.05),
                  color: _themeController.textColor,
                ),
              ),
              SizedBox(
                height: customWidth(0.1),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Dark Mood",
                      style: TextStyle(color: _themeController.textColor),
                    ),
                    Switch(
                      value: _themeController.isLite.value,
                      onChanged: (val) => _themeController.toggleThemeData(),
                      activeColor: SThemeData.lightThemeColor,
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  primary: SThemeData.lightThemeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
