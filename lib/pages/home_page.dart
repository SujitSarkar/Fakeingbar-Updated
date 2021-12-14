import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: customWidth(.065),
          ),
        ),
        //backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pushNamed(context, '/profile'),
          child: Padding(
            padding: EdgeInsets.only(
                top: customWidth(.023),
                left: customWidth(.045),
                bottom: customWidth(.023)),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/m1.jpg"),
              radius: 25.0,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                // CircleAvatar(
                //   backgroundColor: _themeController.backgroundColor,
                //   child: const Icon(
                //     Icons.camera_alt,
                //     color: Colors.black,
                //     size: 20,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(customWidth(.018)),
                  decoration: BoxDecoration(
                    color: _themeController.backgroundColor,
                    borderRadius: BorderRadius.circular(customWidth(.06)),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .035),
                Container(
                  padding: EdgeInsets.all(customWidth(.018)),
                  decoration: BoxDecoration(
                    color: _themeController.backgroundColor,
                    borderRadius: BorderRadius.circular(customWidth(.06)),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _themeController.toggleThemeData(),
          child: const Text('Change Theme'),
        ),
      ),
    );
  }
}
