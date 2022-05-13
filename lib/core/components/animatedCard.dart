// ignore_for_file: file_names

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/text/cardText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';
import '../../view/game/single/game_single_viewmodel.dart';

enum CardFace { back, front }

class AnimatedCard extends StatefulWidget {
  final bool isRotated;
  final int cardStatus;
  final bool isMultiplayer;
  final String text;
  final String whoClickedplayerId;
  final String currentPlayerId;
  const AnimatedCard({
    Key? key,
    required this.text,
    this.onClickCallBack,
    this.isRotated = false,
    this.cardStatus = 0,
    this.isMultiplayer = false,
    this.whoClickedplayerId = '0',
    this.currentPlayerId = '0',
  }) : super(key: key);
  final Function(String text)? onClickCallBack;
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  CardFace currentCardFace = CardFace.back;
  double cardAngle = 0;
  bool isClickedOnce = false;
  Color backColor = Colors.blue.shade700;
  bool isRotated = false; //widget.isRotated;
  int cardStatus = 0;
  AudioCache soundPlayer = AudioCache();
  @override
  void initState() {
    isRotated = widget.isRotated;
    cardStatus = widget.cardStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cardStatus != cardStatus) {
      cardStatus = widget.cardStatus;
      if (cardStatus == 2) {
        backColor = Colors.grey;
        changeAngleOfCard(false);
      } else if (cardStatus == 1) {
        if (widget.currentPlayerId != widget.whoClickedplayerId) {
          backColor = Colors.red;
        } else {
          backColor = Colors.blue.shade700;
        }
        changeAngleOfCard(true);
      }
    }
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: cardAngle),
      duration: const Duration(milliseconds: 400),
      builder: (BuildContext context, double val, __) {
        if (val >= (pi / 2)) {
          currentCardFace = CardFace.back;
        } else {
          currentCardFace = CardFace.front;
        }
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val),

          // ignore: sized_box_for_whitespace
          child: InkWell(
              enableFeedback: false,
              onTap: () async {
                if (widget.onClickCallBack != null && !isClickedOnce) {
                  ClickResponse response = await widget.onClickCallBack!(widget.text);
                  if (response == ClickResponse.wordIsTrue) {
                    if (context.read<SettingsViewModel>().sfxState) {
                      soundPlayer.play("sounds/wordIsTrue.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
                    }
                    cardStatus = 1;
                    backColor = Colors.blue.shade700;
                    changeAngleOfCard(true);
                  } else if (response == ClickResponse.wordIsFalse) {
                    if (context.read<SettingsViewModel>().sfxState) {
                      soundPlayer.play("sounds/wordIsFalse.mp3", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
                    }
                    cardStatus = 2;
                    backColor = Colors.grey;
                    changeAngleOfCard(false);
                  } else {
                    ///Means not your turn...
                    cardStatus = 0;
                  }
                }
              },
              child: currentCardFace == CardFace.back
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.lowRadius), color: backColor,
                        //image: DecorationImage(image: AssetImage(backImagePath), fit: BoxFit.fill),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardText(
                            text: widget.text,
                            color: Colors.white,
                          ),
                          SvgPicture.asset(
                              backColor == Colors.blue.shade700 || backColor == Colors.red
                                  ? 'assets/icons/happy.svg'
                                  : 'assets/icons/sad.svg',
                              width: 25,
                              height: 25)
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.lowRadius),
                        color: const Color.fromARGB(255, 205, 201, 195),
                        border: Border.all(color: const Color.fromARGB(255, 162, 178, 159), width: 3),
                      ),
                      child: Center(child: CardText(text: widget.text)),
                    )),
        );
      },
    );
  }

  void changeAngleOfCard(bool isTrue) {
    if (widget.isMultiplayer) {
      if (!isClickedOnce) {
        cardAngle = (cardAngle + pi * 2);
        isClickedOnce = isTrue;
      }
    } else {
      if (!isClickedOnce) {
        cardAngle = (cardAngle + pi * 2);
        isClickedOnce = true;
      }
    }
    setState(() {});
  }
}
