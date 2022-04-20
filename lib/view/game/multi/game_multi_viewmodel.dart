import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/text/cardText.dart';
import 'package:wordflow/view/player/player.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/components/animatedCard.dart';
import '../../settings/settings_viewmodel.dart';
import '../board/board.dart';
import '../single/game_single_viewmodel.dart';

part 'game_multi_viewmodel.g.dart';

enum GameStatus { stopped, finished, started, initializing }

class GameMultiViewModel = _GameMultiViewModelBase with _$GameMultiViewModel;

abstract class _GameMultiViewModelBase with Store {
  late BuildContext context;

  late IO.Socket socket;

  @observable
  Board board = Board();

  @observable
  Map<String, int> cardListStatus = {};

  @observable
  int round = 0;

  @observable
  int trueWordCount = 0;

  @observable
  GameStatus gameStatus = GameStatus.initializing;

  Player player = Player('You');

  @observable
  var isReferee = false;

  @observable
  String playingPlayerId = '';

  @observable
  String whoPlaysForNextHint = '';

  @observable
  List<String> readyPlayerIds = [];

  @action
  void socketConnect() {
    socket = IO.io("http://192.168.1.5:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((data) {
      debugPrint('connected');
      socket.emit('ready');
      socket.on('unready', handleUnReady);

      debugPrint('socketId' + socket.id.toString());
      socket.on("cardClicked", handleCardClick);
      socket.on("playingPlayerId", (id) {
        playingPlayerId = id.toString();
      });
      socket.on("hintChange", (id) {
        whoPlaysForNextHint = id;
      });
      socket.on('mySocketId', (mess) {
        debugPrint('myId:' + mess.toString());
        socket.id = mess;
      });
      socket.on('playerDisconnected', handleDisconnect);
      socket.on('startGame', handleStartGame);
      socket.on('load', handleLoadGame);
    });

    socket.onDisconnect((_) {
      debugPrint('disconnected');
      readyPlayerIds.remove(socket.id);
      debugPrint(readyPlayerIds.toString());
    });
  }

  @action
  void loadBoardRandomly() {
    board.applyRandomness();
    cardListStatus = board.statusOfCards;
    socket.emit('load', {
      "allWords": board.allWords,
      "currentHint": board.getCurrentHint().toString(),
      "cardListStatus": board.statusOfCards,
    });
  }

  @action
  void startGame() {
    gameStatus = GameStatus.started;
    debugPrint(socket.id.toString());
    //board.cards = cardList;
  }

  //
  //
  //
  @action
  void getModelAndFillData() {
    board.clearData();
    if (currentGameLanguage() == Language.turkish) {
      var testDataTR = [
        {
          "hint": "ülke",
          "relatedWords": ["Mısır", "Fransa", "Turkiye"],
          "totalCount": "3"
        },
        {
          "hint": "yeşil",
          "relatedWords": ["Dolar", "Uzaylı"],
          "totalCount": "2"
        },
        {
          "hint": "tenis",
          "relatedWords": ["Raket", "Basketbol", "Masa"],
          "totalCount": "3"
        },
        {
          "hint": "formula",
          "relatedWords": ["Araba", "Yarış", "Mersedes"],
          "totalCount": "3"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Dev", "Dinozor", "Film"],
          "totalCount": "4"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Dev", "Dinozor", "Film"],
          "totalCount": "4"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Dev", "Dinozor", "Film"],
          "totalCount": "4"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Dev", "Dinozor", "Film"],
          "totalCount": "4"
        },
      ];
      board.fillTable(testDataTR);
    } else {
      var testDataEN = [
        {
          "hint": "country",
          "relatedWords": ["Egypt", "France", "Turkey"],
          "totalCount": "3"
        },
        {
          "hint": "green",
          "relatedWords": ["Dollar", "Alien", "Grey"],
          "totalCount": "3"
        },
        {
          "hint": "tennis",
          "relatedWords": ["Racket", "Basketball", "Table"],
          "totalCount": "3"
        },
        {
          "hint": "tennis1",
          "relatedWords": ["Racket1", "Basketball1", "Table1"],
          "totalCount": "3"
        },
        {
          "hint": "tennis2",
          "relatedWords": ["Racket2", "Basketball2", "Table2"],
          "totalCount": "3"
        },
        {
          "hint": "tennis3",
          "relatedWords": ["Racket3", "Basketball3", "Table3"],
          "totalCount": "3"
        },
        {
          "hint": "formula",
          "relatedWords": ["Car", "Race", "Mercedes"],
          "totalCount": "3"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Giant", "Dinosaur", "Movie"],
          "totalCount": "3"
        },
      ];
      board.fillTable(testDataEN);
    }
    board.setCurrentHint(0, currentGameLanguage());
  }

  @action
  ClickResponse cardClicked(String cardText) {
    debugPrint('Who plays:' + playingPlayerId.toString());

    if (playingPlayerId == socket.id.toString()) {
      ClickResponse response = isWordTrue(cardText);

      if (trueWordCount == board.allWords.length) {
        gameStatus = GameStatus.finished;
      }
      int whoPlayed = readyPlayerIds.indexOf(playingPlayerId);
      if (response == ClickResponse.wordIsFalse) {
        cardListStatus[cardText] = 2;
        if (whoPlayed == 1) {
          socket.emit("playingPlayerId", readyPlayerIds[0]);
        } else {
          socket.emit("playingPlayerId", readyPlayerIds[1]);
        }
      } else {
        cardListStatus[cardText] = 1;
        trueWordCount++;
      }
      if (trueWordCount % 3 == 0 && trueWordCount != 0) {
        round++;
        board.setCurrentHint(round, currentGameLanguage());
        debugPrint('playing:' + playingPlayerId);
        debugPrint('whoWillPlaynextHint' + whoPlaysForNextHint);

        int whoPlayed = readyPlayerIds.indexOf(whoPlaysForNextHint.toString());
        if (whoPlayed == 1) {
          socket.emit("hintChange", readyPlayerIds[0]);
        } else {
          socket.emit("hintChange", readyPlayerIds[1]);
        }
        playingPlayerId = whoPlaysForNextHint;
        socket.emit("playingPlayerId", playingPlayerId);
      }
      socket.emit("cardClicked", {
        "round": round,
        "currentHint": board.getCurrentHint(),
        "cardListStatus": cardListStatus,
        "trueWordCount": trueWordCount
      });
      return response;
    }

    return ClickResponse.notYourTurn;
  }

  @action
  ClickResponse isWordTrue(String clickedWord) {
    if (board.wordsRelationList[round].relatedWords != null) {
      if (board.wordsRelationList[round].relatedWords!.contains(clickedWord)) {
        return ClickResponse.wordIsTrue;
      }
      return ClickResponse.wordIsFalse;
    }
    return ClickResponse.wordIsFalse;
  }

  Language currentGameLanguage() {
    return context.read<SettingsViewModel>().gameLanguage;
  }

  //Socket handlers
  void handleCardClick(data) {
    final Map<String, int> cardListStatusData = Map<String, int>.from(data['cardListStatus']);
    cardListStatus = cardListStatusData;
    round = int.parse(data['round'].toString());
    board.currentHint = data['currentHint'].toString();
    trueWordCount = int.parse(data['trueWordCount'].toString());
  }

  @action
  void handleDisconnect(data) {
    debugPrint('Your opponent has left the game...');
    gameStatus = GameStatus.stopped;
    socket.clearListeners();
    socket.disconnect();
  }

  @action
  void handleUnReady(data) {
    debugPrint('You have left the queue...');
    socket.emit('unready');
    socket.clearListeners();
    socket.disconnect();
  }

  void handleStartGame(playerIds) {
    isReferee = socket.id == playerIds[0];
    final List<String> playerIdsData = List.from(playerIds).map((e) => e as String).toList();
    readyPlayerIds.addAll(playerIdsData);
    playingPlayerId = readyPlayerIds[0].toString();
    whoPlaysForNextHint = readyPlayerIds[1].toString();
    getModelAndFillData();

    if (isReferee) {
      loadBoardRandomly();
    }
    startGame();
  }

  void handleLoadGame(data) {
    final List<String> allWordsData = List.from(data['allWords']).map((e) => e as String).toList();
    board.allWords = allWordsData;

    board.currentHint = data['currentHint'].toString();
    final Map<String, int> cardListStatusData = Map<String, int>.from(data['cardListStatus']);
    cardListStatus = cardListStatusData;
  }
}
