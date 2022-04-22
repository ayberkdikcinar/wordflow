import 'package:wordflow/view/cardStatus_model.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';
import 'package:wordflow/view/wordsRelation/model/words_relation_model.dart';

import 'package:mobx/mobx.dart';
part 'board.g.dart';

class Board = _BoardBase with _$Board;

abstract class _BoardBase with Store {
  List<WordsRelation> wordsRelationList = [];
  List<String> allWords = [];
  List<CardStatus> statusOfCards = []; //0 means not clicked, 1 means clicked and true. 2 means clicked and false.

  @observable
  String currentHint = "";

  void fillTable(List<Map<String, Object>> data) {
    wordsRelationList = data.map((e) => WordsRelation.fromJson(e)).toList();
  }

  void applyRandomness() {
    randomize();
    for (var item in allWords) {
      statusOfCards.add(CardStatus(word: item, status: 0));
    }
  }

  void randomize() {
    for (var i = 0; i < wordsRelationList.length; i++) {
      for (var j = 0; j < wordsRelationList[i].relatedWords!.length; j++) {
        allWords = allWords + [wordsRelationList[i].relatedWords![j].toString()];
      }
    }
    allWords.shuffle();
  }

  @action
  setCurrentHint(int round, Language language) {
    /* if (language == Language.turkish) {
      currentHint = wordsRelationList[round].hint.toString() +
          " ile ilgili " +
          wordsRelationList[round].totalCount.toString() +
          " kelimeyi bul!";
    } else {
      currentHint = "Find " +
          wordsRelationList[round].totalCount.toString() +
          " cards that relate to the clue \"" +
          wordsRelationList[round].hint.toString() +
          "\":";
    }*/
    currentHint = wordsRelationList[round].hint.toString();
  }

  String getCurrentHint() {
    return currentHint;
  }

  void clearData() {
    statusOfCards = [];
    allWords = [];
    wordsRelationList = [];
    currentHint = "";
  }
}
