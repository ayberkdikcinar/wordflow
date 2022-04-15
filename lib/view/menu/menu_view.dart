import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';
import 'package:wordflow/core/constans/enums/app_enums.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/view/game/multi/game_multi_view.dart';
import 'package:wordflow/view/game/single/game_single_view.dart';
import 'package:wordflow/view/game/single/game_single_view.dart';
import 'package:wordflow/view/menu/menu_viewmodel.dart';
import 'package:wordflow/view/settings/settings_view.dart';

import '../../core/init/language/locale_keys.g.dart';
import 'game_mode_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    MenuState menuState = context.watch<MenuViewModel>().currentMenuState;
    debugPrint("main option:" + menuState.toString());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/disp/24e95940185349.57751c99c9df9.gif"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: conditionalWidget(menuState),
          ),
        ),
      ),
    );
  }

  Column menuButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            click: () async {
              debugPrint('play clicked');
              await Future.delayed(const Duration(seconds: 1));
              context.read<MenuViewModel>().changeStatus(MenuState.play);
            },
            text: LocaleKeys.menuPlay.locale),
        CustomButton(
            click: () {
              debugPrint('options clicked');
              context.read<MenuViewModel>().changeStatus(MenuState.options);
            },
            text: LocaleKeys.menuOptions.locale),
        CustomButton(
            click: () {
              debugPrint('help clicked');
            },
            text: LocaleKeys.menuHelp.locale),
        CustomButton(
            click: () {
              debugPrint('exit clicked');
              if (Platform.isAndroid) {
                debugPrint('andro');
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (Platform.isIOS) {
                debugPrint('ios');
                exit(0);
              }
            },
            text: LocaleKeys.menuExit.locale),
      ],
    );
  }

  Widget conditionalWidget(MenuState menuOptions) {
    switch (menuOptions) {
      case MenuState.play:
        return const GameModView();
      //return const GameMultiView();
      case MenuState.singlePlayer:
        return const GameView();
      case MenuState.multiPlayer:
        return const GameMultiView();
      case MenuState.options:
        return Padding(
          padding: EdgeInsets.all(context.highPadding),
          child: SettingsView(
            closeClick: () {
              debugPrint('options view close clicked');
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            },
          ),
        );
      case MenuState.main:
        return menuButtons();
      default:
        return const Text("a");
    }
  }
}
