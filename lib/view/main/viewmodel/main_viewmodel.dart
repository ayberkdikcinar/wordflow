import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
part 'main_viewmodel.g.dart';

enum CardFace { back, front }

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store {
  late BuildContext context;

  @observable
  var isCardFace = CardFace.front;

  @action
  void changeCardFace() {
    if (isCardFace == CardFace.front) {
      isCardFace = CardFace.back;
    } else {
      isCardFace = CardFace.front;
    }
  }

  @observable
  double angleOftheCard = 0;

  @action
  void setCurrentAngleOfCard() {
    angleOftheCard = (angleOftheCard + pi) % (2 * pi);
    //changeCardFace();
  }
}
