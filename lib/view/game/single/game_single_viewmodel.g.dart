// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_single_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameSingleViewModel on _GameSingleViewModelBase, Store {
  final _$socketAtom = Atom(name: '_GameSingleViewModelBase.socket');

  @override
  IO.Socket get socket {
    _$socketAtom.reportRead();
    return super.socket;
  }

  @override
  set socket(IO.Socket value) {
    _$socketAtom.reportWrite(value, super.socket, () {
      super.socket = value;
    });
  }

  final _$roundAtom = Atom(name: '_GameSingleViewModelBase.round');

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

  final _$isGameFinishedAtom =
      Atom(name: '_GameSingleViewModelBase.isGameFinished');

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

  final _$clickCountAtom = Atom(name: '_GameSingleViewModelBase.clickCount');

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

  final _$gameStatusAtom = Atom(name: '_GameSingleViewModelBase.gameStatus');

  @override
  GameStatus get gameStatus {
    _$gameStatusAtom.reportRead();
    return super.gameStatus;
  }

  @override
  set gameStatus(GameStatus value) {
    _$gameStatusAtom.reportWrite(value, super.gameStatus, () {
      super.gameStatus = value;
    });
  }

  final _$_GameSingleViewModelBaseActionController =
      ActionController(name: '_GameSingleViewModelBase');

  @override
  void getModelAndFillData() {
    final _$actionInfo = _$_GameSingleViewModelBaseActionController.startAction(
        name: '_GameSingleViewModelBase.getModelAndFillData');
    try {
      return super.getModelAndFillData();
    } finally {
      _$_GameSingleViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse cardClicked(String cardText) {
    final _$actionInfo = _$_GameSingleViewModelBaseActionController.startAction(
        name: '_GameSingleViewModelBase.cardClicked');
    try {
      return super.cardClicked(cardText);
    } finally {
      _$_GameSingleViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse checkTheCorrectnessOfWord(String clickedWord) {
    final _$actionInfo = _$_GameSingleViewModelBaseActionController.startAction(
        name: '_GameSingleViewModelBase.checkTheCorrectnessOfWord');
    try {
      return super.checkTheCorrectnessOfWord(clickedWord);
    } finally {
      _$_GameSingleViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
socket: ${socket},
round: ${round},
isGameFinished: ${isGameFinished},
clickCount: ${clickCount},
gameStatus: ${gameStatus}
    ''';
  }
}
