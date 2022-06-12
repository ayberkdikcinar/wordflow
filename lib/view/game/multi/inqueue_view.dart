import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/view/game/multi/game_multi_viewmodel.dart';
import 'package:wordflow/view/menu/menu_viewmodel.dart';

import '../../../core/init/language/locale_keys.g.dart';

class InQueueView extends StatefulWidget {
  const InQueueView({Key? key, required this.model}) : super(key: key);
  final GameMultiViewModel model;
  @override
  State<InQueueView> createState() => _InQueueViewState();
}

class _InQueueViewState extends State<InQueueView> {
  AudioCache cache = AudioCache();
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    doSomeMusic();
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.inQueue.locale,
              style: const TextStyle(color: Colors.white, fontSize: 26),
            ),
            AnimatedTextKit(
                animatedTexts: [WavyAnimatedText('...', textStyle: const TextStyle(color: Colors.white, fontSize: 26))],
                repeatForever: true),
          ],
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        CustomButton(
          height: 0.06,
          width: 0.4,
          click: () {
            widget.model.handleUnReady('data');
            context.read<MenuViewModel>().changeStatus(MenuState.play);
          },
          text: LocaleKeys.cancel.locale,
        )
      ],
    );
  }

  void doSomeMusic() async {
    player = await cache.loop('sounds/inqueue_sound.wav');
    // wait 5 sec
  }
}
