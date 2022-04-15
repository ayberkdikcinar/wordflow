// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class GameFinishedCard extends StatefulWidget {
  const GameFinishedCard(
      {Key? key, required this.continueClick, required this.retryClick, required this.homeClick, this.score = 0})
      : super(key: key);
  final Function continueClick;
  final Function retryClick;
  final Function homeClick;
  final int score;
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
          Positioned(
            child: Text(
              'GAME FINISHED',
              style: TextStyle(color: context.defaultTextColor, fontWeight: FontWeight.bold),
            ),
            top: context.dynamicHeight(0.093),
            left: context.dynamicWidth(0.25),
          ),
          Positioned(
            child: Text(
              'SCORE: ${widget.score}',
              style: TextStyle(color: context.defaultTextColor),
            ),
            bottom: context.dynamicHeight(0.09),
            left: context.dynamicWidth(0.3),
          ),
          PositionedIcon(
              context: context,
              bottom: 0,
              left: context.dynamicWidth(0.1),
              imagePath: 'assets/icons/continue.png',
              onTap: widget.continueClick),
          PositionedIcon(
              context: context,
              bottom: 0,
              left: context.dynamicWidth(0.3),
              imagePath: 'assets/icons/retry.png',
              onTap: widget.retryClick),
          PositionedIcon(
              context: context,
              bottom: 0,
              left: context.dynamicWidth(0.5),
              imagePath: 'assets/icons/home.png',
              onTap: widget.homeClick),
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
          height: context.dynamicHeight(0.06),
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
