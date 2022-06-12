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

  final _$cardStatusListAtom =
      Atom(name: '_GameMultiViewModelBase.cardStatusList');

  @override
  List<CardStatus> get cardStatusList {
    _$cardStatusListAtom.reportRead();
    return super.cardStatusList;
  }

  @override
  set cardStatusList(List<CardStatus> value) {
    _$cardStatusListAtom.reportWrite(value, super.cardStatusList, () {
      super.cardStatusList = value;
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

  final _$trueWordCountAtom =
      Atom(name: '_GameMultiViewModelBase.trueWordCount');

  @override
  int get trueWordCount {
    _$trueWordCountAtom.reportRead();
    return super.trueWordCount;
  }

  @override
  set trueWordCount(int value) {
    _$trueWordCountAtom.reportWrite(value, super.trueWordCount, () {
      super.trueWordCount = value;
    });
  }

  final _$gameStatusAtom = Atom(name: '_GameMultiViewModelBase.gameStatus');

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

  final _$opponentScoreAtom =
      Atom(name: '_GameMultiViewModelBase.opponentScore');

  @override
  int get opponentScore {
    _$opponentScoreAtom.reportRead();
    return super.opponentScore;
  }

  @override
  set opponentScore(int value) {
    _$opponentScoreAtom.reportWrite(value, super.opponentScore, () {
      super.opponentScore = value;
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

  final _$playingPlayerIdAtom =
      Atom(name: '_GameMultiViewModelBase.playingPlayerId');

  @override
  String get playingPlayerId {
    _$playingPlayerIdAtom.reportRead();
    return super.playingPlayerId;
  }

  @override
  set playingPlayerId(String value) {
    _$playingPlayerIdAtom.reportWrite(value, super.playingPlayerId, () {
      super.playingPlayerId = value;
    });
  }

  final _$whoPlaysForNextHintAtom =
      Atom(name: '_GameMultiViewModelBase.whoPlaysForNextHint');

  @override
  String get whoPlaysForNextHint {
    _$whoPlaysForNextHintAtom.reportRead();
    return super.whoPlaysForNextHint;
  }

  @override
  set whoPlaysForNextHint(String value) {
    _$whoPlaysForNextHintAtom.reportWrite(value, super.whoPlaysForNextHint, () {
      super.whoPlaysForNextHint = value;
    });
  }

  final _$readyPlayerIdsAtom =
      Atom(name: '_GameMultiViewModelBase.readyPlayerIds');

  @override
  List<String> get readyPlayerIds {
    _$readyPlayerIdsAtom.reportRead();
    return super.readyPlayerIds;
  }

  @override
  set readyPlayerIds(List<String> value) {
    _$readyPlayerIdsAtom.reportWrite(value, super.readyPlayerIds, () {
      super.readyPlayerIds = value;
    });
  }

  final _$getModelAndFillDataAsyncAction =
      AsyncAction('_GameMultiViewModelBase.getModelAndFillData');

  @override
  Future<void> getModelAndFillData() {
    return _$getModelAndFillDataAsyncAction
        .run(() => super.getModelAndFillData());
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
  String turnText() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.turnText');
    try {
      return super.turnText();
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
  ClickResponse checkTheCorrectnessOfWord(String clickedWord) {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.checkTheCorrectnessOfWord');
    try {
      return super.checkTheCorrectnessOfWord(clickedWord);
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTurn() {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.changeTurn');
    try {
      return super.changeTurn();
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleDisconnect(dynamic data) {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.handleDisconnect');
    try {
      return super.handleDisconnect(data);
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleUnReady(dynamic data) {
    final _$actionInfo = _$_GameMultiViewModelBaseActionController.startAction(
        name: '_GameMultiViewModelBase.handleUnReady');
    try {
      return super.handleUnReady(data);
    } finally {
      _$_GameMultiViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
board: ${board},
cardStatusList: ${cardStatusList},
round: ${round},
trueWordCount: ${trueWordCount},
gameStatus: ${gameStatus},
opponentScore: ${opponentScore},
isReferee: ${isReferee},
playingPlayerId: ${playingPlayerId},
whoPlaysForNextHint: ${whoPlaysForNextHint},
readyPlayerIds: ${readyPlayerIds}
    ''';
  }
}
