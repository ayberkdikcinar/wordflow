import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/view/menu/menu_viewmodel.dart';

class InQueueView extends StatefulWidget {
  const InQueueView({Key? key}) : super(key: key);

  @override
  State<InQueueView> createState() => _InQueueViewState();
}

class _InQueueViewState extends State<InQueueView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'In Queue',
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            AnimatedTextKit(
                animatedTexts: [WavyAnimatedText('...', textStyle: const TextStyle(color: Colors.white, fontSize: 26))],
                repeatForever: true),
          ],
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        /* TextButton(
            onPressed: () {
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            },
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white, fontFamily: "ReggaeOne"),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber.shade700),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            )),*/
        CustomButton(
            height: 0.06,
            width: 0.3,
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.play);
            },
            text: 'CANCEL')
      ],
    );
  }
}
