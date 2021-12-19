class User {
  final int id;
  final String name, imageUrl, msg, lastOnlineTime;
  final bool isOnline, hasDay;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.msg,
    required this.lastOnlineTime,
    required this.isOnline,
    required this.hasDay,
  });
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
  ),
  User(
    id: 2,
    name: "Ankur",
    imageUrl: "images/m2.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: false,
    hasDay: true,
  ),
  User(
    id: 3,
    name: "Stella",
    imageUrl: "images/w2.jpg",
    msg: "Hey What's up?",
    lastOnlineTime: " . Wed",
    isOnline: true,
    hasDay: false,
  ),
  User(
    id: 4,
    name: "Gabriela",
    imageUrl: "images/w1.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: true,
    hasDay: true,
  ),
  User(
    id: 5,
    name: "Rudolf",
    imageUrl: "images/w1.jpg",
    msg: "Lets meet tomorrow",
    lastOnlineTime: " . 3:09 PM",
    isOnline: true,
    hasDay: true,
  ),
];
