// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:wordflow/core/components/text/cardText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

import '../../view/game/single/game_single_viewmodel.dart';

enum CardFace { back, front }

class AnimatedCard extends StatefulWidget {
  final bool isRotated;
  final int cardStatus;
  final String text;
  const AnimatedCard({
    Key? key,
    required this.text,
    this.onClickCallBack,
    this.isRotated = false,
    this.cardStatus = 0,
  }) : super(key: key);
  final Function(String text)? onClickCallBack;
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  CardFace currentCardFace = CardFace.back;
  double cardAngle = 0;
  bool isClickedOnce = false;
  String backImagePath = "assets/cards/blue-agent.png";
  bool isRotated = false; //widget.isRotated;
  int cardStatus = 0;
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
        backImagePath = "assets/cards/grey-agent.png";
        changeAngleOfCard();
      } else if (cardStatus == 1) {
        backImagePath = "assets/cards/blue-agent.png";
        changeAngleOfCard();
      }
    }
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: cardAngle),
      duration: const Duration(milliseconds: 500),
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
            onTap: () async {
              if (widget.onClickCallBack != null && !isClickedOnce) {
                ClickResponse response = await widget.onClickCallBack!(widget.text);
                if (response == ClickResponse.wordIsTrue) {
                  cardStatus = 1;
                  changeAngleOfCard();
                } else if (response == ClickResponse.wordIsFalse) {
                  cardStatus = 2;
                  backImagePath = "assets/cards/grey-agent.png";
                  changeAngleOfCard();
                } else {
                  ///Means not your turn...
                  cardStatus = 0;
                  debugPrint('not your turn!!!!');

                  ///Burdan gelen değer geri döndürülecek!
                }
              }
              //widget.onClick();
              //debugPrint('tıklandı');
            },
            child: currentCardFace == CardFace.back
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(backImagePath), fit: BoxFit.fill),
                    ),
                  )
                : Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      const Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/cards/front.png'),
                      ),
                      Positioned(
                          bottom: context.dynamicHeight(0.02),
                          child: SizedBox(
                              height: context.dynamicHeight(0.036),
                              width: context.dynamicWidth(0.26),
                              child: Center(child: CardText(text: widget.text))))
                    ],
                  ),
          ),
        );
      },
    );
  }

  void changeAngleOfCard() {
    if (!isClickedOnce) {
      cardAngle = (cardAngle + pi) % (2 * pi);
      isClickedOnce = true;
      setState(() {});
    }
  }
}
