// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class HintText extends StatelessWidget {
  const HintText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.dynamicHeight(0.15),
      width: context.dynamicWidth(0.4),
      decoration: BoxDecoration(border: Border.all(color: Colors.white), color: Colors.black),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontSize: context.highTextSize, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/**/ 