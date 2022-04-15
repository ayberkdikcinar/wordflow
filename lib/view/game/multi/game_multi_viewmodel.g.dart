// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_multi_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameMultiViewModel on _GameMultiViewModelBase, Store {
  final _$boardAtom = Atom(name: '_GameMultiViewModelBase.board');

  @override
  Board get board {
    _$boardAtom.reportRead();
    return super.board;
  }

  @override
  set board(Board value) {
    _$boardAtom.reportWrite(value, super.board, () {
      super.board = value;
    });
  }

  final _$cardListStatusAtom =
      Atom(name: '_GameMultiViewModelBase.cardListStatus');

  @override
  Map<String, int> get cardListStatus {
    _$cardListStatusAtom.reportRead();
    return super.cardListStatus;
  }

  @override
  set cardListStatus(Map<String, int> value) {
    _$cardListStatusAtom.reportWrite(value, super.cardListStatus, () {
      super.cardListStatus = value;
    });
  }

  final _$roundAtom = Atom(name: '_GameMultiViewModelBase.round');

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

  final _$clickCountAtom = Atom(name: '_GameMultiViewModelBase.clickCount');

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

  final _$isGameFinishedAtom =
      Atom(name: '_GameMultiViewModelBase.isGameFinished');

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

  final _$isGameStartedAtom =
      Atom(name: '_GameMultiViewModelBase.isGameStarted');

  @override
  bool get isGameStarted {
    _$isGameStartedAtom.reportRead();
    return super.isGameStarted;
  }

  @override
  set isGameStarted(bool value) {
    _$isGameStartedAtom.reportWrite(value, super.isGameStarted, () {
      super.isGameStarted = value;
    });
  }

  final _$isRefereeAtom = Atom(name: '_GameMultiViewModelBase.isReferee');

  @override
  bool get isReferee {
    _$isRefereeAtom.reportRead();
    return super.isReferee;
  }

  @override
  set isReferee(bool value) {
    _$isRefereeAtom.reportWrite(value, super.isReferee, () {
      super.isReferee = value;
    });
  }

  final _$changeGameStatusAsyncAction =
      AsyncAction('_GameMultiViewModelBase.changeGameStatus');

  @override
  Future<void> changeGameStatus() {
    return _$changeGameStatusAsyncAction.run(() => super.changeGameStatus());
  }

  final _$_GameMultiViewModelBaseActionController =
      ActionController(name: '_GameMultiViewModelBase');

  @override
  void socketConnect() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.socketConnect');
    try {
      return super.socketConnect();
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadBoardRandomly() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.loadBoardRandomly');
    try {
      return super.loadBoardRandomly();
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startGame() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.startGame');
    try {
      return super.startGame();
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getModelAndFillData() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.getModelAndFillData');
    try {
      return super.getModelAndFillData();
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse cardClicked(String cardText) {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.cardClicked');
    try {
      return super.cardClicked(cardText);
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ClickResponse isWordTrue(String clickedWord) {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.isWordTrue');
    try {
      return super.isWordTrue(clickedWord);
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
board: ${board},
cardListStatus: ${cardListStatus},
round: ${round},
clickCount: ${clickCount},
isGameFinished: ${isGameFinished},
isGameStarted: ${isGameStarted},
isReferee: ${isReferee}
    ''';
  }
}
