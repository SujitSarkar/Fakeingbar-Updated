import 'dart:io';

import 'package:fakeingbar/data/local_database.dart/database_controller.dart';

class ChatListController extends DatabaseController {
  void userBlockToggole(int id, isBlock) async {
    int userid = await updateUser(
      currentUser.value.copyWith(isBlock: isBlock == true ? false : true),
      id,
    );
    updateCurrentUser(id);
  }

  updateProfilePic(int id) async {
    File? image = await pickImage();
    if (image != null) {
      await updateUser(
        currentUser.value.copyWith(imageUrl: image.path),
        id,
      );
      updateCurrentUser(id);
    }
  }
}
