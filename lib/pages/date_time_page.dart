import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePage extends StatefulWidget {
  DateTimePage({Key? key}) : super(key: key);

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  int _radioSelected = 1;
  final String _time = "Set Time", _date = "Set Date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RadioListTile<int>(
              contentPadding: EdgeInsets.all(0),
              title: Text("Daily Time"),
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
              title: Text("Monthly Time"),
              value: 2,
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
              title: Text("Yearly Time"),
              value: 3,
              groupValue: _radioSelected,
              activeColor: SThemeData.lightThemeColor,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                });
              },
            ),
            Row(
              children: [
                Text(
                  _time,
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Set Time"),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  _date,
                  style: Theme.of(context).textTheme.headline4,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Set Date"),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () => Get.back,
              child: Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
