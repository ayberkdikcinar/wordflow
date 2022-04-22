import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/customButton.dart';

import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';

import 'package:wordflow/view/game/multi/game_multi_view.dart';
import 'package:wordflow/view/game/single/game_single_view.dart';
import 'package:wordflow/view/menu/help_view.dart';

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
  DateTime? timeBackPressed;

  @override
  Widget build(BuildContext context) {
    MenuState menuState = context.watch<MenuViewModel>().currentMenuState;
    //AudioCache soundPlayer = AudioCache();

    return WillPopScope(
      onWillPop: () async {
        final differeance = timeBackPressed == null ? null : DateTime.now().difference(timeBackPressed!);
        timeBackPressed = DateTime.now();
        if (differeance == null || differeance >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: LocaleKeys.willPopScope.locale);
          return false;
        } else {
          Fluttertoast.cancel();
          //NavigationService.instance.navigatePop();
          //Navigat.back(id: navigationKey?.id);
          return true;
        }
      },
      child: SafeArea(
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
      ),
    );
  }

  Column menuButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.play);
            },
            text: LocaleKeys.menuPlay.locale),
        CustomButton(
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.options);
            },
            text: LocaleKeys.menuOptions.locale),
        CustomButton(
            click: () {
              context.read<MenuViewModel>().changeStatus(MenuState.help);
            },
            text: LocaleKeys.menuHelp.locale),
        CustomButton(
            click: () {
              if (Platform.isAndroid) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (Platform.isIOS) {
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
      case MenuState.singlePlayer:
        return const GameView();
      case MenuState.multiPlayer:
        return const GameMultiView();
      case MenuState.help:
        return const HelpView();
      case MenuState.options:
        return Padding(
          padding: EdgeInsets.all(context.highPadding),
          child: SettingsView(
            closeClick: () {
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            },
          ),
        );
      case MenuState.main:
        return menuButtons();
      default:
        return const Text("Error");
    }
  }

  /*play() async {
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    await audioPlayer.play("assets/sounds/menu_music.wav", isLocal: true, stayAwake: false);
  }*/
}
