// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wordflow/core/components/positionedIcon.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';

import '../init/language/locale_keys.g.dart';

class AlertCard extends StatefulWidget {
  const AlertCard({Key? key, required this.continueClick, required this.retryClick, required this.homeClick}) : super(key: key);
  final Function continueClick;
  final Function retryClick;
  final Function homeClick;

  @override
  State<AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> {
  double cardHeight = 0;
  @override
  Widget build(BuildContext context) {
    cardHeight = context.dynamicWidth(0.4);
    return SizedBox(
      height: cardHeight,
      child: Stack(
        children: [
          const Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/cards/pop-up-background.png'),
          ),
          Positioned(
            child: Text(
              LocaleKeys.gameDropped.locale,
              style: TextStyle(color: context.defaultTextColor, fontWeight: FontWeight.bold),
            ),
            top: cardHeight * 0.06,
            left: cardHeight * 0.25,
          ),
          Positioned(
            child: Text(
              LocaleKeys.gameDropError.locale,
              style: TextStyle(color: context.defaultTextColor),
            ),
            top: cardHeight * 0.4,
            left: cardHeight * 0.06,
          ),
          PositionedIcon(
              context: context, bottom: 0, left: cardHeight * 0.4, imagePath: 'assets/icons/home.png', onTap: widget.homeClick),
        ],
      ),
    );
  }
}
