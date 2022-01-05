import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:fakeingbar/widgets/k_filled_button.dart';
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
  int _radioSelected = 0;

  final _showDate = false.obs;
  final _showTime = false.obs;
  bool _is24Hour = false;

  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime(DateTime.now().year);

  late int userId;

  @override
  Widget build(BuildContext context) {
    DateTime tempTime = DateFormat("hh:mm")
        .parse(_time.hour.toString() + ":" + _time.minute.toString());
    String formatedTime = _showTime.isTrue
        ? DateFormat(_is24Hour ? "HH:mm:ss" : "h:mm a").format(tempTime)
        : "";
    String formatedDate =
        _showDate.isTrue ? DateFormat('yMMMd').format(_date) + " AT " : "";
    _dateTimeController.text = "$formatedDate $formatedTime";
    return GetBuilder<DatabaseController>(
      builder: (_databaseController) {
        userId = _databaseController.currentUser.value.id!;
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close)),
                ),
                Padding(
                  padding: EdgeInsets.all(customWidth(.1)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RadioListTile<int>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Daily Time"),
                          value: 1,
                          groupValue: _radioSelected,
                          activeColor: SThemeData.lightThemeColor,
                          onChanged: (value) {
                            setState(() {
                              _radioSelected = value!;
                              _showDate.value = false;
                              _showTime.value = true;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Monthly Time"),
                          value: 2,
                          groupValue: _radioSelected,
                          activeColor: SThemeData.lightThemeColor,
                          onChanged: (value) {
                            setState(() {
                              _radioSelected = value!;
                              _showDate.value = true;
                              _showTime.value = true;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Yearly Time"),
                          value: 3,
                          groupValue: _radioSelected,
                          activeColor: SThemeData.lightThemeColor,
                          onChanged: (value) {
                            setState(() {
                              _radioSelected = value!;
                              _showDate.value = true;
                              _showTime.value = true;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("24-hour formate"),
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
                        Obx(
                          () => _showTime.isTrue
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Set Time",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    KFilledButton(
                                      text: "Set Time",
                                      width: customWidth(.28),
                                      btnColor: SThemeData.blueDotColor,
                                      onPressed: () => _selectTime(),
                                    )
                                  ],
                                )
                              : Container(),
                        ),
                        Obx(
                          () => _showDate.isTrue
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Set Date",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    KFilledButton(
                                      text: "Set Date",
                                      width: customWidth(.28),
                                      btnColor: SThemeData.blueDotColor,
                                      onPressed: () => _selectDate(),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: customWidth(.05)),
                          child: TextField(
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            controller: _dateTimeController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        KFilledButton(
                          text: "Save",
                          btnColor: SThemeData.blueDotColor,
                          onPressed: () {
                            _databaseController.insertChat(
                              ChatListModel(
                                friendListID: userId,
                                sendMessage: _dateTimeController.text.trim(),
                                memberID: "",
                                receiveMessage: "",
                                senderTime: DateTime.now(),
                                receiveTime: DateTime.now(),
                                isReceived: "dateTime",
                              ),
                            );
                            _databaseController.currentUserChats.add(
                              ChatListModel(
                                friendListID: userId,
                                sendMessage: _dateTimeController.text.trim(),
                                memberID: "",
                                receiveMessage: "",
                                senderTime: DateTime.now(),
                                receiveTime: DateTime.now(),
                                isReceived: "dateTime",
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
