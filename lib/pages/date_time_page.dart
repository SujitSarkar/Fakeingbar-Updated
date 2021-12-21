import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimePage extends StatefulWidget {
  DateTimePage({Key? key}) : super(key: key);

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  final TextEditingController _dateTimeController = TextEditingController();
  int _radioSelected = 1;

  final _showDateTime = false.obs;
  bool _is24Hour = false;

  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  DateTime _date = DateTime(DateTime.now().year);

  @override
  Widget build(BuildContext context) {
    _dateTimeController.text =
        "${DateFormat('EEE, M/d/y').format(_date)} ${_time.format(context)}";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () => Get.back(), icon: Icon(Icons.close)),
            ),
            Padding(
              padding: EdgeInsets.all(customWidth(.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
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
                        _showDateTime.value = false;
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
                        _showDateTime.value = true;
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
                        _showDateTime.value = true;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("24-hour formate"),
                      Switch(
                        value: _is24Hour,
                        onChanged: (value) {
                          setState(() {
                            _is24Hour = !_is24Hour;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Set Time",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: SThemeData.lightThemeColor,
                        ),
                        onPressed: () => _selectTime(),
                        child: Text("Set Time"),
                      )
                    ],
                  ),
                  Obx(
                    () => _showDateTime.isTrue
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Set Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: SThemeData.lightThemeColor,
                                ),
                                onPressed: () => _selectDate(),
                                child: Text("Set Date"),
                              )
                            ],
                          )
                        : Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: customWidth(.05)),
                    child: TextField(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      controller: _dateTimeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: SThemeData.lightThemeColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Done"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }
}
