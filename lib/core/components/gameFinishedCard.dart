// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wordflow/core/components/positionedIcon.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/core/init/language/locale_keys.g.dart';

class GameFinishedCard extends StatefulWidget {
  const GameFinishedCard(
      {Key? key,
      required this.continueClick,
      required this.retryClick,
      required this.homeClick,
      this.score = 0,
      this.opponentScore = -999})
      : super(key: key);
  final Function continueClick;
  final Function retryClick;
  final Function homeClick;
  final int score;
  final int opponentScore;
  @override
  State<GameFinishedCard> createState() => _GameFinishedCardState();
}

class _GameFinishedCardState extends State<GameFinishedCard> {
  double cardHeight = 0;
  @override
  Widget build(BuildContext context) {
    cardHeight = context.dynamicWidth(0.8);
    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          const Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/cards/game-finished.png'),
          ),
          Positioned(
            child: Text(
              LocaleKeys.gameFinished.locale,
              style: TextStyle(color: context.defaultTextColor, fontWeight: FontWeight.bold),
            ),
            top: cardHeight * 0.2,
            left: cardHeight * 0.33,
          ),
          if (widget.opponentScore != -999)
            Positioned(
              child: Text(
                widget.score > widget.opponentScore
                    ? 'YOU WON'
                    : widget.score == widget.opponentScore
                        ? 'DRAW'
                        : 'YOU LOST',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              top: cardHeight * 0.35,
              left: cardHeight * 0.33,
            ),
          Positioned(
            child: Text(
              '${LocaleKeys.score.locale.toUpperCase()}: ${widget.score}',
              style: TextStyle(color: context.defaultTextColor),
            ),
            top: cardHeight * 0.75,
            left: cardHeight * 0.33,
          ),
          PositionedIcon(
              context: context,
              bottom: 0,
              left: cardHeight * 0.22,
              imagePath: 'assets/icons/continue.png',
              onTap: widget.continueClick),
          PositionedIcon(
              context: context,
              bottom: 0,
              left: cardHeight * 0.42,
              imagePath: 'assets/icons/retry.png',
              onTap: widget.retryClick),
          PositionedIcon(
              context: context, bottom: 0, left: cardHeight * 0.62, imagePath: 'assets/icons/home.png', onTap: widget.homeClick),
        ],
      ),
    );
  }
}
