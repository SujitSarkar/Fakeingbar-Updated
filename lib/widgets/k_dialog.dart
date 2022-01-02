import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config.dart';
import 'k_filled_button.dart';
import 'k_image_picker.dart';

class KDialog extends StatelessWidget {
  KDialog({
    Key? key,
    required DatabaseController databaseController,
    required TextEditingController newChatName,
    required this.name,
    required this.hintText,
    required this.onPressed,
  })  : _databaseController = databaseController,
        _newChatName = newChatName,
        super(key: key);

  final ThemeController _themeController = Get.find();
  final DatabaseController _databaseController;
  final TextEditingController _newChatName;
  final String name, hintText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(builder: (context, setState) {
        return IntrinsicHeight(
          // height: customWidth(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: _themeController.backgroundColor,
                padding: EdgeInsets.symmetric(
                    horizontal: customWidth(.04), vertical: customWidth(.02)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: _themeController.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: customWidth(.05),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              KImagePicker(),
              SizedBox(
                height: customWidth(.05),
              ),
              TextField(
                controller: _newChatName,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _themeController.textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: customWidth(.05),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: customWidth(.04),
                ),
                child: KFilledButton(
                  text: "Create",
                  btnColor: SThemeData.blueDotColor,
                  onPressed: onPressed,
                ),
              ),
              SizedBox(
                height: customWidth(.02),
              ),
            ],
          ),
        );
      }),
    );
  }
}
