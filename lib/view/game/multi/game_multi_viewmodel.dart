import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/base/model/base_gameviewmodel.dart';

import 'package:wordflow/view/cardStatus_model.dart';
import 'package:wordflow/view/player/player.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wordflow/view/wordsRelation/model/words_relation_model.dart';

import '../../../core/init/network/network_manager.dart';
import '../../settings/settings_viewmodel.dart';
import '../board/board.dart';
import '../single/game_single_viewmodel.dart';

part 'game_multi_viewmodel.g.dart';

enum GameStatus { stopped, finished, started, initializing, error }

class GameMultiViewModel = _GameMultiViewModelBase with _$GameMultiViewModel;

abstract class _GameMultiViewModelBase extends BaseGameViewModel with Store {
  late BuildContext context;

  late IO.Socket socket;

  @observable
  Board board = Board();

  @observable
  List<CardStatus> cardStatusList = [];
  @observable
  int round = 0;

  @observable
  int trueWordCount = 0;

  @observable
  GameStatus gameStatus = GameStatus.initializing;

  Player player = Player('You');

  @observable
  int opponentScore = 0;

  @observable
  var isReferee = false;

  @observable
  String playingPlayerId = '';

  @observable
  String whoPlaysForNextHint = '';

  @observable
  List<String> readyPlayerIds = [];

  NetworkManager networkManager = NetworkManager.instance;

  AudioCache soundPlayer = AudioCache();

  @action
  void socketConnect() {
    //http://192.168.1.5:3000
    //https://wordflow-socket-server.herokuapp.com/
    socket = IO.io("https://wordflow-socket-server.herokuapp.com/", <String, dynamic>{
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

        if (context.read<SettingsViewModel>().sfxState) {
          soundPlayer.play("sounds/word_changed.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
        }
      });
      socket.on('mySocketId', (mess) {
        debugPrint('myId:' + mess.toString());
        socket.id = mess;
      });
      socket.on('playerDisconnected', handleDisconnect);
      socket.on('startGame', handleStartGame);
      socket.on('load', handleLoadGame);
      socket.on('gameFinished', (_) {
        gameStatus = GameStatus.finished;
        soundPlayer.play("sounds/game_finished.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
      });
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
    cardStatusList = board.statusOfCards;
    socket.emit('load', {
      "allWords": board.allWords,
      "currentHint": board.getCurrentHint().toString(),
      "cardListStatus": board.statusOfCards,
      "wordRelations": board.wordsRelationList,
    });
  }

  @action
  void startGame() {
    gameStatus = GameStatus.started;
  }

  @action
  String turnText() {
    return playingPlayerId == socket.id.toString() ? 'YOUR TURN' : 'OPPONENT TURN';
  }

  @action
  Future<void> getModelAndFillData() async {
    board.clearData();
    String path = "http://20.117.168.133:5000/";
    if (currentGameLanguage() == Language.turkish) {
      path = "http://20.117.168.133:5000/tr";
    }
    var testDataEN = await networkManager.dioGet(path: path, model: WordsRelation());
    List<WordsRelation> list = testDataEN.cast<WordsRelation>();

    board.fillTable(list);

    board.setCurrentHint(0, currentGameLanguage());
  }

  @override
  @action
  ClickResponse cardClicked(String cardText) {
    if (playingPlayerId == socket.id.toString()) {
      int indexOfElement = -1;
      for (var i = 0; i < cardStatusList.length; i++) {
        if (cardStatusList[i].word == cardText) {
          indexOfElement = i;
          break;
        }
      }
      ClickResponse response = checkTheCorrectnessOfWord(cardText);

      //int whoPlayed = readyPlayerIds.indexOf(playingPlayerId);
      if (response == ClickResponse.wordIsFalse) {
        cardStatusList[indexOfElement].status = 2;
        player.setScore(player.getScore - 2);
        changeTurn();
      } else {
        player.setScore(player.getScore + 10);
        cardStatusList[indexOfElement].status = 1;
        cardStatusList[indexOfElement].playerId = playingPlayerId;
        trueWordCount++;
        if (trueWordCount % 3 == 0 && trueWordCount != 0 && trueWordCount < board.allWords.length) {
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
          //playingPlayerId = whoPlaysForNextHint;
          socket.emit("playingPlayerId", whoPlaysForNextHint);
        }
      }

      socket.emit("cardClicked", {
        "round": round,
        "currentHint": board.getCurrentHint(),
        "cardListStatus": cardStatusList,
        "trueWordCount": trueWordCount,
        "playerScore": {"id": socket.id, "score": player.getScore}
      });
      if (trueWordCount == board.allWords.length) {
        gameStatus = GameStatus.finished;
        socket.emit('gameFinished');
      }
      return response;
    }

    return ClickResponse.notYourTurn;
  }

  @override
  @action
  ClickResponse checkTheCorrectnessOfWord(String clickedWord) {
    if (board.wordsRelationList[round].relatedWords != null) {
      if (board.wordsRelationList[round].relatedWords!.contains(clickedWord)) {
        return ClickResponse.wordIsTrue;
      }
      return ClickResponse.wordIsFalse;
    }
    return ClickResponse.wordIsFalse;
  }

  @action
  void changeTurn() {
    int whoPlayed = readyPlayerIds.indexOf(playingPlayerId);
    if (whoPlayed == 1) {
      socket.emit("playingPlayerId", readyPlayerIds[0]);
    } else {
      socket.emit("playingPlayerId", readyPlayerIds[1]);
    }
  }

  @override
  Language currentGameLanguage() {
    return context.read<SettingsViewModel>().gameLanguage;
  }

  //Socket handlers
  void handleCardClick(data) {
    /*final Map<String, int> cardListStatusData = Map<String, int>.from(data['cardListStatus']);
    cardListStatus = cardListStatusData;*/
    final List<CardStatus> cardStatData = data['cardListStatus'].map<CardStatus>((e) => CardStatus.fromJson(e)).toList();
    cardStatusList = cardStatData;
    round = int.parse(data['round'].toString());
    board.currentHint = data['currentHint'].toString();
    trueWordCount = int.parse(data['trueWordCount'].toString());

    if (data['playerScore']['id'].toString() != socket.id) {
      opponentScore = int.parse(data['playerScore']['score'].toString());
    }
  }

  @action
  void handleDisconnect(data) {
    debugPrint('Your opponent has left the game...');
    gameStatus = GameStatus.stopped;
    socket.clearListeners();
    socket.disconnect();

    soundPlayer.play("sounds/disconnected.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
  }

  @action
  void handleUnReady(data) {
    debugPrint('You have left the queue...');
    socket.emit('unready');
    socket.clearListeners();
    socket.disconnect();
  }

  Future<void> handleStartGame(playerIds) async {
    isReferee = socket.id == playerIds[0];
    final List<String> playerIdsData = List.from(playerIds).map((e) => e as String).toList();
    readyPlayerIds.addAll(playerIdsData);
    playingPlayerId = readyPlayerIds[0].toString();
    whoPlaysForNextHint = readyPlayerIds[1].toString();

    soundPlayer.play("sounds/connected.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);

    if (isReferee) {
      await getModelAndFillData();
      loadBoardRandomly();
    }
    startGame();
  }

  void handleLoadGame(data) {
    final List<String> allWordsData = List.from(data['allWords']).map((e) => e as String).toList();
    board.allWords = allWordsData;
    final List<WordsRelation> wordRelationsData = List.from(data['wordRelations']).map((e) => WordsRelation.fromJson(e)).toList();
    board.currentHint = data['currentHint'].toString();
    board.wordsRelationList = wordRelationsData;
    final List<CardStatus> cardStatData = data['cardListStatus'].map<CardStatus>((e) => CardStatus.fromJson(e)).toList();
    cardStatusList = cardStatData;
  }
}
