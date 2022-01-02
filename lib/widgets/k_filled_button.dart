import 'package:fakeingbar/config.dart';
import 'package:fakeingbar/variables/theme_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KFilledButton extends StatelessWidget {
  const KFilledButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.borderRadius,
      this.height = 40,
      this.width = double.infinity,
      this.btnColor})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double? borderRadius;
  final double height;
  final double width;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5.0)),
        ),
      ),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: btnColor ?? Theme.of(context).primaryColor,
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 5.0))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: customWidth(.048),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
