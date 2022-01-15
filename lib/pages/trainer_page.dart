import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/data/local_database.dart/database_controller.dart';
import 'package:fakeingbar/models/trainer_chat_model.dart';
import 'package:fakeingbar/widgets/k_chat_dialog.dart';
import 'package:fakeingbar/widgets/k_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerPage extends StatelessWidget {
  TrainerPage({Key? key}) : super(key: key);

  final ThemeController _themeController = Get.find();
  final _sendMsgController = TextEditingController();
  final _replyMsgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<DatabaseController>(
          builder: (_databaseController) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: customWidth(.05),
                    ),
                    Text(
                      "Trainer Page",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: customWidth(.065),
                        color: _themeController.textColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(
                    customWidth(.05),
                  ),
                  child: KFilledButton(
                    text: "Add",
                    onPressed: () => showAddDialog(context),
                  ),
                ),
                _databaseController.trainerChatList.isEmpty
                    ? const Text("No Trainer Added...")
                    : const SizedBox(),
                ..._databaseController.trainerChatList.map(
                  (tCHat) => Padding(
                    padding: EdgeInsets.only(
                      left: customWidth(.05),
                      right: customWidth(.05),
                      bottom: customWidth(.02),
                    ),
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      shape: Border.all(
                          color: _themeController.textColor.withOpacity(.3)),
                      title: Text(
                        tCHat.question!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${tCHat.answer!}\t",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      trailing: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _sendMsgController.text = tCHat.question!;
                              _replyMsgController.text = tCHat.answer!;
                              showEditDialog(context, tCHat);
                            },
                            child: Icon(
                              Icons.edit,
                              size: customWidth(.05),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _databaseController.deleteTrainerChat(tCHat.id!);
                            },
                            child: Icon(
                              Icons.delete,
                              size: customWidth(.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showEditDialog(BuildContext context, TrainerChatModel chat) {
    showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<DatabaseController>(
          builder: (_databaseController) {
            return KChatDialog(
              name: "Trainer",
              firstText: _sendMsgController,
              secondText: _replyMsgController,
              hintText1: "Write Send Message",
              hintText2: "Write Reply Message",
              btnText: "Save",
              onPressed: () async {
                await _databaseController.updateTrainerChat(
                  chat.copyWith(
                    answer: _replyMsgController.text,
                    question: _sendMsgController.text,
                  ),
                  chat.id!,
                );
                _sendMsgController.clear();
                _replyMsgController.clear();
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<DatabaseController>(
          builder: (_databaseController) {
            return KChatDialog(
              name: "Trainer",
              firstText: _sendMsgController,
              secondText: _replyMsgController,
              hintText1: "Write Send Message",
              hintText2: "Write Reply Message",
              btnText: "Save",
              onPressed: () async {
                await _databaseController.insertTrainerChat(
                  TrainerChatModel(
                    question: _sendMsgController.text.trim(),
                    answer: _replyMsgController.text.trim(),
                  ),
                );
                _sendMsgController.clear();
                _replyMsgController.clear();
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
