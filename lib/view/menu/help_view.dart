import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/view/menu/menu_viewmodel.dart';

import '../../core/components/positionedIcon.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.5),
      width: context.dynamicWidth(0.8),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/cards/classic_container.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              height: context.dynamicHeight(0.4),
              width: context.dynamicWidth(0.7),
              child: Column(
                children: [
                  Text(
                    'HOW TO PLAY\n',
                    style: TextStyle(fontSize: context.highTextSize, color: Colors.black),
                  ),
                  const Text('MULTIPLAYER BASIC RULES\n'),
                  const Text('eğer böyle olursa şöyle olur\n'),
                  const Text('SINGLEPLAYER BASIC RULES\n'),
                ],
              )),
          closeIcon(context)
        ],
      ),
    );
  }

  PositionedIcon closeIcon(BuildContext context) {
    return PositionedIcon(
        context: context,
        bottom: 0,
        left: context.dynamicWidth(0.33),
        imagePath: "assets/icons/close.png",
        onTap: () {
          context.read<MenuViewModel>().changeStatus(MenuState.main);
        });
  }
}
