import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/gameFinishedCard.dart';
import 'package:wordflow/core/components/switchButton.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/core/init/language/locale_keys.g.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

import '../../core/init/theme/theme_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.closeClick}) : super(key: key);
  final Function closeClick;
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool stateCheckBox = false;
  bool stateCheckBox2 = false;
  String dropdownValue = LocaleKeys.english.locale;
  String dropdownValue2 = LocaleKeys.turkish.locale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Image(
            image: AssetImage("assets/cards/pop-up-background.png"),
            fit: BoxFit.fill,
            height: 330,
          ),
          Positioned(
            left: 110,
            top: 10,
            child: Text(LocaleKeys.menuOptions.locale,
                style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.extraHighTextSize)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(LocaleKeys.musicVolume.locale,
                            style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: Colors.red))),
                    Expanded(
                      child: musicCheckBoxButton(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(LocaleKeys.sfxVolume.locale,
                            style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: Colors.red))),
                    Expanded(
                      child: sfxCheckBoxButton(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(LocaleKeys.gameLanguage.locale,
                            style: TextStyle(
                                fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: context.theme.cardColor))),
                    Expanded(
                      child: languageDropDownButton(context),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(LocaleKeys.darkMode.locale,
                            style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: Colors.red))),
                    Expanded(
                      child: MenuSwitchButton(
                        icon: Icons.dangerous,
                        title: "Hey",
                        onPressed: (val) {
                          context.read<ThemeManager>().changeDarkMode(val);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          PositionedIcon(context: context, bottom: 40, left: 90, imagePath: "assets/icons/tick.png", onTap: () {}),
          PositionedIcon(
              context: context,
              bottom: 40,
              left: 170,
              imagePath: "assets/icons/close.png",
              onTap: () {
                widget.closeClick();
              })
        ],
      ),
    );
  }

  DropdownButton<String> languageDropDownButton(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      style: TextStyle(color: Colors.white, fontSize: context.normalIconSize),
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if (newValue == "İngilizce") {
            context.read<SettingsViewModel>().changeGameLanguage(Language.english);
            debugPrint(context.read<SettingsViewModel>().gameLanguage.toString());
          } else {
            context.read<SettingsViewModel>().changeGameLanguage(Language.turkish);
            debugPrint(context.read<SettingsViewModel>().gameLanguage.toString());
          }
        });
      },
      items: <String>[LocaleKeys.english.locale, LocaleKeys.turkish.locale].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  IconButton musicCheckBoxButton() {
    return IconButton(
      onPressed: () {
        debugPrint('runned');
        setState(() {
          stateCheckBox = !stateCheckBox;
        });
      },
      icon: stateCheckBox ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
      color: Colors.white,
      iconSize: 30,
    );
  }

  IconButton sfxCheckBoxButton() {
    return IconButton(
      onPressed: () {
        debugPrint('runned');
        setState(() {
          stateCheckBox2 = !stateCheckBox2;
        });
      },
      icon: stateCheckBox2 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
      color: Colors.white,
      iconSize: 30,
    );
  }
}
