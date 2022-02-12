import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  double dynamicHeight(double value) => MediaQuery.of(context).size.height;
  double dynamicWidht(double value) => MediaQuery.of(context).size.width;
}
