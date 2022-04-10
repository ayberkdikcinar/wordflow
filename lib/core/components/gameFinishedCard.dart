// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class GameFinishedCard extends StatefulWidget {
  const GameFinishedCard({Key? key, required this.continueClick, required this.retryClick, required this.homeClick}) : super(key: key);
  final Function continueClick;
  final Function retryClick;
  final Function homeClick;
  @override
  State<GameFinishedCard> createState() => _GameFinishedCardState();
}

class _GameFinishedCardState extends State<GameFinishedCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.45),
      child: Stack(
        children: [
          const Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/cards/game-finished.png'),
          ),
          PositionedIcon(context: context, bottom: 0, left: 40, imagePath: 'assets/icons/continue.png', onTap: widget.continueClick),
          PositionedIcon(context: context, bottom: 0, left: 130, imagePath: 'assets/icons/retry.png', onTap: widget.retryClick),
          PositionedIcon(context: context, bottom: 0, left: 220, imagePath: 'assets/icons/home.png', onTap: widget.homeClick),
        ],
      ),
    );
  }
}

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
          height: context.dynamicHeight(0.07),
          width: context.dynamicWidth(0.2),
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
