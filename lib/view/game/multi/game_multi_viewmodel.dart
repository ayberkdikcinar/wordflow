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
  int clickCount = 0;
  @observable
  bool isGameFinished = false;
  @observable
  bool isGameStarted = false;

  Player player1 = Player('You');
  Player player2 = Player('Opponnent');

  @observable
  var isReferee = false;

  @observable
  String playingPlayerId = '';

  List<String> readyPlayerIds = [];

  @action
  void socketConnect() {
    socket = IO.io("http://192.168.144.1:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    //tur arttıgında referee oyuncuda kartlar normale dönüyor.
    socket.onConnect((data) {
      debugPrint('connected');
      socket.emit('ready');

      socket.on("cardClicked", (data) {
        final Map<String, int> cardListStatusData = Map<String, int>.from(data['cardListStatus']);
        cardListStatus = cardListStatusData;
        round = int.parse(data['round'].toString());
        board.currentHint = data['currentHint'].toString();
      });
      socket.on("playingPlayerId", (id) {
        playingPlayerId = id.toString();
      });

      socket.on('startGame', (playerIds) {
        debugPrint('referee is' + playerIds[0]);
        isReferee = socket.id == playerIds[0];
        final List<String> playerIdsData = List.from(playerIds).map((e) => e as String).toList();
        readyPlayerIds.addAll(playerIdsData);
        playingPlayerId = readyPlayerIds[0].toString();
        debugPrint(readyPlayerIds.toString());
        getModelAndFillData();
        if (isReferee) {
          //this is closed for the test issue.
          loadBoardRandomly();
        }
        //loadBoardRandomly();
        debugPrint(board.allWords.length.toString());
        socket.on('load', (data) {
          final List<String> allWordsData = List.from(data['allWords']).map((e) => e as String).toList();
          board.allWords = allWordsData;

          board.currentHint = data['currentHint'].toString();
          final Map<String, int> cardListStatusData = Map<String, int>.from(data['cardListStatus']);
          cardListStatus = cardListStatusData;
        });

        startGame();
      });
    });

    socket.onDisconnect((_) {
      debugPrint('disconnected');
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
    isGameStarted = true;
    debugPrint(socket.id.toString());
    //board.cards = cardList;
  }

  //
  //
  //
  @action
  void getModelAndFillData() {
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
          "relatedWords": ["Dollar", "Alien"],
          "totalCount": "2"
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
          "relatedWords": ["Tokyo", "Giant", "Dinosaur", "Movie"],
          "totalCount": "4"
        },
      ];
      board.fillTable(testDataEN);
    }
    board.setCurrentHint(0, currentGameLanguage());
  }

  @action
  ClickResponse cardClicked(String cardText) {
    ///hinti burda değiştiriyorum, oyunu burada bitiriyorum, textin doğruluğunu burada yapıyorum
    debugPrint(playingPlayerId.toString());
    if (playingPlayerId == socket.id.toString()) {
      debugPrint('player oynadı:' + playingPlayerId + " socketid:" + socket.id.toString());
      clickCount++;
      ClickResponse response = isWordTrue(cardText);

      if (clickCount == int.parse(board.wordsRelationList[round].totalCount!)) {
        debugPrint(board.wordsRelationList.length.toString());
        if (round < board.wordsRelationList.length - 1) {
          round++;
          clickCount = 0;
          board.setCurrentHint(round, currentGameLanguage());
        } else {
          changeGameStatus();
        }
      }
      if (response == ClickResponse.wordIsFalse) {
        cardListStatus[cardText] = 2;
      } else {
        cardListStatus[cardText] = 1;
      }

      socket.emit("cardClicked", {"round": round, "currentHint": board.getCurrentHint(), "cardListStatus": cardListStatus});
      int whoPlayed = readyPlayerIds.indexOf(socket.id.toString());
      if (response != ClickResponse.wordIsTrue) {
        if (whoPlayed == 1) {
          socket.emit("playingPlayerId", readyPlayerIds[0]);
        } else {
          socket.emit("playingPlayerId", readyPlayerIds[1]);
        }
      }
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

  @action
  Future<void> changeGameStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isGameFinished = !isGameFinished;
  }

  Language currentGameLanguage() {
    return context.read<SettingsViewModel>().gameLanguage;
  }
}
