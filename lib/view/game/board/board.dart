import 'package:wordflow/view/settings/settings_viewmodel.dart';
import 'package:wordflow/view/wordsRelation/model/words_relation_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'board.g.dart';

class Board = _BoardBase with _$Board;

abstract class _BoardBase with Store {
  List<WordsRelation> wordsRelationList = [];
  List<String> allWords = [];

  @observable
  String currentHint = "";

  void fillTable(List<Map<String, Object>> data) {
    wordsRelationList = [];
    wordsRelationList = data.map((e) => WordsRelation.fromJson(e)).toList();
    randomize();
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
    if (language == Language.turkish) {
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
    }
  }
}