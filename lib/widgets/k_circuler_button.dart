import 'package:flutter/material.dart';

class KCirculerButton extends StatelessWidget {
  const KCirculerButton({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Opacity(
          opacity: .6,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: Icon(
            Icons.person_add_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
