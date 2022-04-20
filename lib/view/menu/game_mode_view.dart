import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/core/init/language/locale_keys.g.dart';

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
            width: 0.7,
            text: LocaleKeys.singlePlayer.locale),
        CustomButton(
            height: 0.08,
            width: 0.7,
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.multiPlayer);
            },
            text: LocaleKeys.multiPlayer.locale),
        CustomButton(
            height: 0.08,
            width: 0.7,
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            },
            text: LocaleKeys.mainMenu.locale),
      ],
    ));
  }
}
