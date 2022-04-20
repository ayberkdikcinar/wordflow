import 'package:flutter/material.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

class CardText extends StatelessWidget {
  const CardText({Key? key, required this.text, this.color = Colors.black}) : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: context.highTextSize, fontWeight: FontWeight.w700, color: color),
      overflow: TextOverflow.ellipsis,
    );
  }
}
