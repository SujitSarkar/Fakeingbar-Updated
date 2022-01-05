import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';
import 'k_filled_button.dart';
import 'k_image_picker.dart';

class KChatDialog extends StatelessWidget {
  KChatDialog({
    Key? key,
    required TextEditingController welcomeMsg,
    required TextEditingController address,
    required this.name,
    required this.hintText1,
    required this.hintText2,
    required this.btnText,
    required this.onPressed,
  })  : _welcomeMsg = welcomeMsg,
        _address = address,
        super(key: key);

  final ThemeController _themeController = Get.find();
  final TextEditingController _welcomeMsg;
  final TextEditingController _address;
  final String name, hintText1, hintText2, btnText;
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
              TextField(
                controller: _welcomeMsg,
                decoration: InputDecoration(
                  hintText: hintText1,
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
              TextField(
                controller: _address,
                decoration: InputDecoration(
                  hintText: hintText2,
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
                  text: btnText,
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
