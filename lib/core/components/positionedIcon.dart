import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class PositionedIcon extends StatelessWidget {
  const PositionedIcon({
    Key? key,
    required this.context,
    required this.bottom,
    required this.left,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final double left;
  final double bottom;
  final String imagePath;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: SizedBox(
          height: context.dynamicWidth(0.1),
          width: context.dynamicWidth(0.15),
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
