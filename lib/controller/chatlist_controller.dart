import 'package:fakeingbar/data/local_database.dart/database_controller.dart';

class ChatListController extends DatabaseController {
  void userBlockToggole(int id) {
    // userList.firstWhere((element) => element.id == id).isBlock =
    updateUser(
        currentUser.value.copyWith(isBlock: !currentUser.value.isBlock!), id);
    updateCurrentUser(id);
  }
}
