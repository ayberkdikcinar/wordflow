// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Board on _BoardBase, Store {
  final _$currentHintAtom = Atom(name: '_BoardBase.currentHint');

  @override
  String get currentHint {
    _$currentHintAtom.reportRead();
    return super.currentHint;
  }

  @override
  set currentHint(String value) {
    _$currentHintAtom.reportWrite(value, super.currentHint, () {
      super.currentHint = value;
    });
  }

  final _$_BoardBaseActionController = ActionController(name: '_BoardBase');

  @override
  dynamic setCurrentHint(int round, Language language) {
    final _$actionInfo = _$_BoardBaseActionController.startAction(
        name: '_BoardBase.setCurrentHint');
    try {
      return super.setCurrentHint(round, language);
    } finally {
      _$_BoardBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentHint: ${currentHint}
    ''';
  }
}
