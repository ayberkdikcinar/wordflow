import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class HintText extends StatelessWidget {
  const HintText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: context.titleTextSize, fontWeight: FontWeight.w700),
    );
  }
}
