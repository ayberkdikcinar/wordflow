import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';

import '../game/single/game_single_view.dart';
import 'menu_viewmodel.dart';

class GameModView extends StatelessWidget {
  const GameModView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.singlePlayer);
            },
            height: 0.08,
            width: 0.5,
            text: 'SINGLE PLAYER'),
        CustomButton(
            height: 0.08,
            width: 0.5,
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.multiPlayer);
            },
            text: 'MULTI PLAYER'),
        CustomButton(
            height: 0.08,
            width: 0.5,
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            },
            text: 'MAIN MENU'),
      ],
    ));
  }
}
