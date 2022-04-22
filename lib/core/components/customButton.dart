import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

import '../../view/settings/settings_viewmodel.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.click, required this.text, this.height = 0.07, this.width = 0.4}) : super(key: key);
  final Function click;
  final String text;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    AudioCache soundPlayer = AudioCache();

    return InkWell(
      enableFeedback: false,
      onTap: () async {
        if (context.read<SettingsViewModel>().sfxState) {
          soundPlayer.play("sounds/btn-click.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
        }
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
