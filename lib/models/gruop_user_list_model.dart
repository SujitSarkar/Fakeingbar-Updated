import 'package:flutter_contacts/properties/group.dart';

class GroupUserListModel {
  int? id;
  int? friendListID;
  String? name;
  String? imageUrl;

  GroupUserListModel({
    this.friendListID,
    this.name,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['friendListID'] = friendListID;
    map['name'] = name;
    map['imageUrl'] = imageUrl;

    return map;
  }

  //Extract a note object from a map object
  GroupUserListModel.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    friendListID = int.parse(map['friendListID']);
    name = map['name'];
    imageUrl = map['imageUrl'];
  }

  //copyWith Method
  GroupUserListModel copyWith({
    int? friendListID,
    String? name,
    String? imageUrl,
  }) {
    return GroupUserListModel(
      friendListID: friendListID ?? this.friendListID,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
