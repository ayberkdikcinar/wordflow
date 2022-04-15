import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.click, required this.text, this.height = 0.07, this.width = 0.4}) : super(key: key);
  final Function click;
  final String text;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    AudioCache soundPlayer = AudioCache();

    return GestureDetector(
      onTap: () async {
        soundPlayer.play("sounds/btn-click.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
        click();
      },
      child: Padding(
        padding: EdgeInsets.all(context.lowPadding),
        child: Stack(
          alignment: Alignment.center,
          children: [buttonImage(context), buttonText(context)],
        ),
      ),
    );
  }

  Text buttonText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.extraHighTextSize),
    );
  }

  Image buttonImage(BuildContext context) {
    return Image(
      image: const AssetImage("assets/buttons/main_button.png"),
      fit: BoxFit.fill,
      height: context.dynamicHeight(height),
      width: context.dynamicWidth(width),
    );
  }
}
