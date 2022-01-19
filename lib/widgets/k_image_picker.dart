import 'dart:io';

import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';

class KImagePicker extends StatefulWidget {
  KImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<KImagePicker> createState() => _KImagePickerState();
}

class _KImagePickerState extends State<KImagePicker> {
  final ThemeController _themeController = Get.find();
  final DatabaseController _databaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          File? image = await _databaseController.pickImage();
          if (image != null) {
            setState(() {
              _themeController.imageFile = image;
            });
          }
        },
        child: Container(
          width: customWidth(.2),
          height: customWidth(.2),
          // padding: EdgeInsets.all(customWidth(.03)),
          // clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: _themeController.chatBGColor,
            border: Border.all(
              color: SThemeData.lightThemeColor,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(customWidth(.2))),
                child: Container(
                  width: customWidth(.2),
                  height: customWidth(.2),
                  child: _themeController.imageFile == null
                      ? Image.asset(
                          "images/person.png",
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          _themeController.imageFile!,
                          width: customWidth(.4),
                          height: customWidth(.4),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                bottom: customWidth(.025),
                right: customWidth(.025),
                child: Container(
                  decoration: BoxDecoration(
                    color: _themeController.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: _themeController.darkenTextColor,
                    size: customWidth(.05),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
