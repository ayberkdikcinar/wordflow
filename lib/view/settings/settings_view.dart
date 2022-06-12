import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/core/extensions/string_extension.dart';
import 'package:wordflow/core/init/language/locale_keys.g.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

import '../../core/components/positionedIcon.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.closeClick}) : super(key: key);
  final Function closeClick;
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool stateCheckBox = false;
  String dropdownValue = LocaleKeys.english.locale;

  @override
  Widget build(BuildContext context) {
    bool sfxCheckBox = context.read<SettingsViewModel>().sfxState;
    return SizedBox(
      height: context.dynamicWidth(0.8),
      width: context.dynamicWidth(0.8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Image(
            image: AssetImage("assets/cards/pop-up-background.png"),
          ),
          Positioned(
            left: context.dynamicWidth(0.2),
            top: context.dynamicWidth(0.08),
            child: Container(
              height: context.dynamicWidth(0.1),
              width: context.dynamicWidth(0.4),
              alignment: Alignment.center,
              child: Text(LocaleKeys.menuOptions.locale,
                  style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.extraHighTextSize)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: context.extraHighPadding, right: context.highPadding, top: context.extraHighPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sfxVolumeRow(context, sfxCheckBox),
                languageRow(context),
              ],
            ),
          ),
          closeIcon(context)
        ],
      ),
    );
  }

  PositionedIcon closeIcon(BuildContext context) {
    return PositionedIcon(
        context: context,
        bottom: context.dynamicWidth(0.04),
        left: context.dynamicWidth(0.34),
        imagePath: "assets/icons/close.png",
        onTap: () {
          widget.closeClick();
        });
  }

  Row languageRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(LocaleKeys.gameLanguage.locale,
                style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: Colors.white))),
        Expanded(
          flex: 1,
          child: languageDropDownButton(context),
        )
      ],
    );
  }

  Row sfxVolumeRow(BuildContext context, bool sfxCheckBox) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(LocaleKeys.sfxVolume.locale,
                style: TextStyle(fontFamily: "ReggaeOne", fontSize: context.titleTextSize, color: Colors.white))),
        Expanded(
          child: sfxCheckBoxButton(sfxCheckBox),
        )
      ],
    );
  }

  DropdownButton<String> languageDropDownButton(BuildContext context) {
    return DropdownButton<String>(
      value: context.read<SettingsViewModel>().gameLanguage == Language.english
          ? LocaleKeys.english.locale
          : LocaleKeys.turkish.locale,
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
      style: TextStyle(color: Colors.white, fontSize: context.normalIconSize),
      underline: const SizedBox(),
      dropdownColor: Colors.black,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if (newValue == LocaleKeys.english.locale) {
            context.read<SettingsViewModel>().changeGameLanguage(Language.english);
          } else {
            context.read<SettingsViewModel>().changeGameLanguage(Language.turkish);
          }
        });
      },
      items: <String>[LocaleKeys.english.locale, LocaleKeys.turkish.locale].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: context.highTextSize, fontWeight: FontWeight.bold)),
        );
      }).toList(),
    );
  }

  /*IconButton musicCheckBoxButton() {
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
  }*/

  IconButton sfxCheckBoxButton(bool state) {
    return IconButton(
      onPressed: () {
        setState(() {
          context.read<SettingsViewModel>().changeSFXState(!state);
        });
      },
      icon: state ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
      color: Colors.white,
      iconSize: context.extraHighIconSize,
    );
  }
}
