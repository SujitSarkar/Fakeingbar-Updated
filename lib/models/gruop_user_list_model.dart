class GroupUserListModel {
  int? id;
  int? friendListID;
  String? name;
  String? imageUrl;

  GroupUserListModel({
    required this.friendListID,
    required this.name,
    required this.imageUrl,
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
}
