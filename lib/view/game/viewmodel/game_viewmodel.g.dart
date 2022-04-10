// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameViewModel on _GameViewModelBase, Store {
  final _$roundAtom = Atom(name: '_GameViewModelBase.round');

  @override
  int get round {
    _$roundAtom.reportRead();
    return super.round;
  }

  @override
  set round(int value) {
    _$roundAtom.reportWrite(value, super.round, () {
      super.round = value;
    });
  }

  final _$isGameFinishedAtom = Atom(name: '_GameViewModelBase.isGameFinished');

  @override
  bool get isGameFinished {
    _$isGameFinishedAtom.reportRead();
    return super.isGameFinished;
  }

  @override
  set isGameFinished(bool value) {
    _$isGameFinishedAtom.reportWrite(value, super.isGameFinished, () {
      super.isGameFinished = value;
    });
  }

  final _$clickCountAtom = Atom(name: '_GameViewModelBase.clickCount');

  @override
  int get clickCount {
    _$clickCountAtom.reportRead();
    return super.clickCount;
  }

  @override
  set clickCount(int value) {
    _$clickCountAtom.reportWrite(value, super.clickCount, () {
      super.clickCount = value;
    });
  }

  final _$changeGameStatusAsyncAction =
      AsyncAction('_GameViewModelBase.changeGameStatus');

  @override
  Future<void> changeGameStatus() {
    return _$changeGameStatusAsyncAction.run(() => super.changeGameStatus());
  }

  final _$_GameViewModelBaseActionController =
      ActionController(name: '_GameViewModelBase');

  @override
  void getModelAndFillData() {
    final _$actionInfo = _$_GameViewModelBaseActionController.startAction(
        name: '_GameViewModelBase.getModelAndFillData');
    try {
      return super.getModelAndFillData();
    } finally {
      _$_GameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse cardClicked(String cardText) {
    final _$actionInfo = _$_GameViewModelBaseActionController.startAction(
        name: '_GameViewModelBase.cardClicked');
    try {
      return super.cardClicked(cardText);
    } finally {
      _$_GameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse isWordTrue(String clickedWord) {
    final _$actionInfo = _$_GameViewModelBaseActionController.startAction(
        name: '_GameViewModelBase.isWordTrue');
    try {
      return super.isWordTrue(clickedWord);
    } finally {
      _$_GameViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
round: ${round},
isGameFinished: ${isGameFinished},
clickCount: ${clickCount}
    ''';
  }
}
