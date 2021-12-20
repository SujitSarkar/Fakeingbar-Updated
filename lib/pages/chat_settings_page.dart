import 'package:fakeingbar/models/user.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSettingsPage extends StatefulWidget {
  ChatSettingsPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ChatSettingsPage> createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  int _radioSelected = 1;

  final List<Color> _chatColors = [
    Colors.blueAccent,
    Colors.cyan,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.indigoAccent,
    Colors.green,
    Colors.deepOrangeAccent,
    Colors.indigoAccent,
    Colors.limeAccent,
    Colors.pinkAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Edit Name"),
            TextField(
              decoration: InputDecoration(label: Text(widget.user.name)),
            ),
            Text("Online Status"),
            RadioListTile<int>(
              contentPadding: EdgeInsets.all(0),
              title: Text("Active"),
              value: 1,
              groupValue: _radioSelected,
              activeColor: SThemeData.lightThemeColor,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                });
              },
            ),
            RadioListTile<int>(
              contentPadding: EdgeInsets.all(0),
              title: Text("Active Age"),
              value: 2,
              groupValue: _radioSelected,
              activeColor: SThemeData.lightThemeColor,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                label: Text(
                    _radioSelected == 1 ? "Active Now" : "Active 2 hours ago"),
              ),
            ),
            Text("Select Chat Color"),
            Wrap(
              children: [
                ..._chatColors.map(
                  (e) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => Get.back,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
