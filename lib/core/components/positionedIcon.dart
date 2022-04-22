import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

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
      child: InkWell(
        onTap: () async {
          if (context.read<SettingsViewModel>().sfxState) {
            AudioCache soundPlayer = AudioCache();
            soundPlayer.play("sounds/btn-click.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
          }
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
