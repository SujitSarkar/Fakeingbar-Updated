import 'package:fakeingbar/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KCirculerButton extends StatelessWidget {
  KCirculerButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.size,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  double? size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      child: child,
      color: Colors.white10.withOpacity(.4),
      shape: const CircleBorder(),
      minWidth: size ?? 50,
      height: size ?? 50,
    );
  }
}
