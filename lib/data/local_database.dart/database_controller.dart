import 'dart:io';

import 'package:fakeingbar/data/local_database.dart/string.dart';
import 'package:fakeingbar/models/chat_list_model.dart';
import 'package:fakeingbar/models/friend_list_model.dart';
import 'package:fakeingbar/models/gruop_user_list_model.dart';
import 'package:fakeingbar/models/trainer_chat_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends GetxController {
  RxList<FriendListModel> userList = <FriendListModel>[].obs;
  RxList<ChatListModel> chatList = <ChatListModel>[].obs;
  RxList<GroupUserListModel> groupUserList = <GroupUserListModel>[].obs;
  RxList<TrainerChatModel> trainerChatList = <TrainerChatModel>[].obs;

  static const _databaseName = "ChatDatabase.db";
  static const _databaseVersion = 1;

  static Database? _database; //singleton Database

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await initializeDatabase();
    return _database!;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${KStrings.tableFriendList}(${KStrings.colFriendListId} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${KStrings.colFriendListName} TEXT, ${KStrings.colFriendListImageUrl} TEXT, '
        '${KStrings.colLastMessageTime} TEXT, ${KStrings.colLastMessage} TEXT, '
        '${KStrings.colMessageStatus} TEXT, ${KStrings.colIsOnline} TEXT, '
        '${KStrings.colIsBlock} TEXT, ${KStrings.colHasDay} TEXT, '
        '${KStrings.colChatColor} TEXT, ${KStrings.colInactiveTime} TEXT, '
        '${KStrings.colWelcomeMessage} TEXT, ${KStrings.colAddress} TEXT, '
        '${KStrings.colHasGroup} TEXT)');

    await db.execute(
        'CREATE TABLE ${KStrings.tableChatList}(${KStrings.colChatListId} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${KStrings.colMemberID} TEXT, ${KStrings.colFkChatListFriendId} TEXT, '
        '${KStrings.colSendMessage} TEXT, ${KStrings.colReceiveMessage} TEXT, '
        '${KStrings.colSenderTime} TEXT, ${KStrings.colReceiveTime} TEXT, '
        '${KStrings.colIsReceived} TEXT)');

    await db.execute(
        'CREATE TABLE ${KStrings.tableGroupList}(${KStrings.colGroupListId} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${KStrings.colGroupMemberName} TEXT, ${KStrings.colFkGroupFriendID} TEXT, '
        '${KStrings.colGroupMemberImageUrl} TEXT)');

    await db.execute(
        'CREATE TABLE ${KStrings.tableTrainer}(${KStrings.colTrainerId} INTEGER PRIMARY KEY AUTOINCREMENT, '
        '${KStrings.colQuestion} TEXT, ${KStrings.colAnswer} TEXT)');
  }

  Future<Database> initializeDatabase() async {
    ///Get the directory path for both android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _databaseName;
    var addressDatabase = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
    );
    return addressDatabase;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  @override
  void onInit() {
    super.onInit();
    getUserList();
    getChatList();
    getGroupUserList();
  }

  ///Fetch "Friendlist" as Map list from DB
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await database;
    var result = await db.query(KStrings.tableFriendList,
        orderBy: '${KStrings.colFriendListId} ASC');
    return result;
  }

  ///Get the "Map list" and convert it to "Friend list"
  Future<void> getUserList() async {
    userList.clear();
    var userMapList = await getUserMapList();

    for (var userMap in userMapList) {
      print("User...: $userMap");
      userList.add(FriendListModel.fromMapObject(userMap));
    }
    update();
  }

  ///Update FriendList
  Future<int> updateUser(FriendListModel user, int id) async {
    Database db = await database;
    var result = await db.update(
      KStrings.tableFriendList,
      user.toMap(),
      where: '${KStrings.colFriendListId} = ?',
      whereArgs: [id.toString()],
    );
    await getUserList();
    update();
    return result;
  }

  ///Insert FriendList
  Future<int> insertUser(FriendListModel user) async {
    print(user);
    Database db = await database;
    var result = await db.insert(KStrings.tableFriendList, user.toMap());
    await getUserList();
    print("User Added...........$result");
    update();
    return result;
  }

  ///Delete Friend List along with Chat and Group included with that user
  Future<int> deleteUser(int id) async {
    Database db = await database;
    var result = await db.delete(
      KStrings.tableFriendList,
      where: '${KStrings.colFriendListId} = ?',
      whereArgs: [id.toString()],
    );
    await db.delete(
      KStrings.tableChatList,
      where: "${KStrings.colFkChatListFriendId} = ?",
      whereArgs: [id.toString()],
    );
    await db.delete(
      KStrings.tableGroupList,
      where: "${KStrings.colFkGroupFriendID} = ?",
      whereArgs: [id.toString()],
    );
    await getUserList();
    update();
    return result;
  }

  ///Fetch "Chat List" as Map list from DB
  Future<List<Map<String, dynamic>>> getChatMapList() async {
    Database db = await database;
    var result = await db.query(KStrings.tableChatList,
        orderBy: '${KStrings.colSenderTime} DESC');
    return result;
  }

  ///Get the "Map list" and convert it to "Chat list"
  Future<void> getChatList() async {
    chatList.clear();
    var chatMapList = await getChatMapList();

    for (var chatMap in chatMapList) {
      print("Chats....:$chatMap");
      chatList.add(ChatListModel.fromMapObject(chatMap));
    }
    update();
  }

  ///Update Chat
  Future<int> updateChat(ChatListModel chat, int id) async {
    Database db = await database;
    var result = await db.update(
      KStrings.tableChatList,
      chat.toMap(),
      where: '${KStrings.colChatListId} = ?',
      whereArgs: [id.toString()],
    );
    await getChatList();
    update();
    return result;
  }

  ///Insert Chat
  Future<int> insertChat(ChatListModel chat) async {
    print(chat);
    Database db = await database;
    var result = await db.insert(KStrings.tableChatList, chat.toMap());
    await getChatList();
    print("Chat addeed........$result");
    update();
    return result;
  }

  ///Delete Chat
  Future<int> deleteChat(int id) async {
    Database db = await database;
    var result = await db.delete(
      KStrings.tableChatList,
      where: '${KStrings.colChatListId} = ?',
      whereArgs: [id.toString()],
    );

    await getChatList();
    update();
    return result;
  }

  ///Fetch "Gruop User List" as Map list from DB
  Future<List<Map<String, dynamic>>> getGroupUserMapList() async {
    Database db = await database;
    var result = await db.query(KStrings.tableGroupList,
        orderBy: '${KStrings.colGroupListId} ASC');
    return result;
  }

  ///Get the "Map list" and convert it to "Group User list"
  Future<void> getGroupUserList() async {
    groupUserList.clear();
    var groupUserMapList = await getGroupUserMapList();

    for (var groupUserMap in groupUserMapList) {
      print("Group....: $groupUserMap");
      groupUserList.add(GroupUserListModel.fromMapObject(groupUserMap));
    }
    update();
  }

  ///Update Group User
  Future<int> updateGroupUser(GroupUserListModel groupUser, int id) async {
    Database db = await database;
    var result = await db.update(
      KStrings.tableGroupList,
      groupUser.toMap(),
      where: '${KStrings.colGroupListId} = ?',
      whereArgs: [id.toString()],
    );
    await getGroupUserList();
    update();
    return result;
  }

  ///Insert Group User List
  Future<int> insertGroupUser(GroupUserListModel groupUser) async {
    Database db = await database;
    var result = await db.insert(KStrings.tableGroupList, groupUser.toMap());
    await getGroupUserList();
    update();
    return result;
  }

  ///Delete Group User List
  Future<int> deleteGroupUser(int id) async {
    Database db = await database;
    var result = await db.delete(
      KStrings.tableGroupList,
      where: '${KStrings.colGroupListId} = ?',
      whereArgs: [id.toString()],
    );

    await getGroupUserList();
    update();
    return result;
  }

  ///Fetch "Trainer Chat List" as Map list from DB
  Future<List<Map<String, dynamic>>> getTrainerChatMapList() async {
    Database db = await database;
    var result = await db.query(KStrings.tableTrainer,
        orderBy: '${KStrings.colTrainerId} ASC');

    return result;
  }

  ///Get the "Map list" and convert it to "Trainer Chat list"
  Future<void> getTrainerChatList() async {
    trainerChatList.clear();
    var trainerChatMapList = await getTrainerChatMapList();

    for (var trainerChatMap in trainerChatMapList) {
      trainerChatList.add(TrainerChatModel.fromMapObject(trainerChatMap));
    }
    update();
  }

  ///Update Trainer Chat
  Future<int> updateTrainerChat(TrainerChatModel trainerChat, int id) async {
    Database db = await database;
    var result = await db.update(
      KStrings.tableTrainer,
      trainerChat.toMap(),
      where: '${KStrings.colTrainerId} = ?',
      whereArgs: [id.toString()],
    );
    await getTrainerChatList();
    update();
    return result;
  }

  ///Insert Trainer Chat
  Future<int> insertTrainerChat(TrainerChatModel trainerChat) async {
    Database db = await database;
    var result = await db.insert(KStrings.tableTrainer, trainerChat.toMap());
    await getTrainerChatList();
    update();
    return result;
  }

  ///Delete Trainer Chat
  Future<int> deleteTrainerChat(int id) async {
    Database db = await database;
    var result = await db.delete(
      KStrings.tableTrainer,
      where: '${KStrings.colTrainerId} = ?',
      whereArgs: [id.toString()],
    );

    await getTrainerChatList();
    update();
    return result;
  }
}
