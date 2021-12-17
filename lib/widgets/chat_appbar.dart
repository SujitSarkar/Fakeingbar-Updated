import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/controller/theme_controller.dart';
import 'package:fakeingbar/widgets/custom_circle_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatAppBarAction extends StatefulWidget {
  List<Widget> actions = []; //List<Widget>(0);
  final String title;
  final bool isScroll;
  final bool isOnline;
  final bool isBack;
  final String subTitle;
  final String imageUrl;

  ChatAppBarAction({
    Key? key,
    required this.actions,
    this.title = '',
    required this.isScroll,
    required this.isBack,
    required this.isOnline,
    required this.subTitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ChatAppBarActionState createState() => _ChatAppBarActionState();
}

class _ChatAppBarActionState extends State<ChatAppBarAction> {
  final ThemeController _themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      padding: const EdgeInsets.only(right: 12.0, top: 25.0),
      decoration: BoxDecoration(
        color: _themeController.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: widget.isScroll ? Colors.black12 : Colors.white,
            offset: const Offset(0.0, 1.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context); //Routes.goBack(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 25.0,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              Container(
                width: 16.0,
              ),
              SizedBox(
                height: customWidth(.1),
                width: customWidth(.1),
                child: CustomeCircleAvatar(
                  name: widget.title,
                  imgUrl: widget.imageUrl,
                  isOnline: widget.isOnline,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 120.0,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    widget.subTitle,
                    style: TextStyle(color: Colors.grey, fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Row(
                children: widget.actions
                    .map((c) => Container(
                          padding: EdgeInsets.only(left: 7.0),
                          child: c,
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
