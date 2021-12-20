class User {
  final int id;
  final String name, msg, lastOnlineTime;
  final bool isOnline, hasDay;
  String imageUrl;
  bool isBlock;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.msg,
    required this.lastOnlineTime,
    required this.isOnline,
    required this.hasDay,
    required this.isBlock,
  });
  set setIsBlock(bool block) {
    isBlock = block;
  }
}

List<User> users = [
  User(
    id: 1,
    name: "Evan Hossain",
    imageUrl: "images/w1.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: true,
    hasDay: true,
    isBlock: true,
  ),
  User(
    id: 2,
    name: "Ankur",
    imageUrl: "images/m2.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: false,
    hasDay: true,
    isBlock: false,
  ),
  User(
    id: 3,
    name: "Stella",
    imageUrl: "images/w2.jpg",
    msg: "Hey What's up?",
    lastOnlineTime: " . Wed",
    isOnline: true,
    hasDay: false,
    isBlock: false,
  ),
  User(
    id: 4,
    name: "Gabriela",
    imageUrl: "images/w1.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: true,
    hasDay: true,
    isBlock: false,
  ),
  User(
    id: 5,
    name: "Rudolf",
    imageUrl: "images/w1.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: true,
    hasDay: true,
    isBlock: false,
  ),
];
