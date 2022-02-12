// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainViewModel on _MainViewModelBase, Store {
  final _$isCardFaceAtom = Atom(name: '_MainViewModelBase.isCardFace');

  @override
  CardFace get isCardFace {
    _$isCardFaceAtom.reportRead();
    return super.isCardFace;
  }

  @override
  set isCardFace(CardFace value) {
    _$isCardFaceAtom.reportWrite(value, super.isCardFace, () {
      super.isCardFace = value;
    });
  }

  final _$angleOftheCardAtom = Atom(name: '_MainViewModelBase.angleOftheCard');

  @override
  double get angleOftheCard {
    _$angleOftheCardAtom.reportRead();
    return super.angleOftheCard;
  }

  @override
  set angleOftheCard(double value) {
    _$angleOftheCardAtom.reportWrite(value, super.angleOftheCard, () {
      super.angleOftheCard = value;
    });
  }

  final _$_MainViewModelBaseActionController =
      ActionController(name: '_MainViewModelBase');

  @override
  void changeCardFace() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changeCardFace');
    try {
      return super.changeCardFace();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentAngleOfCard() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.setCurrentAngleOfCard');
    try {
      return super.setCurrentAngleOfCard();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isCardFace: ${isCardFace},
angleOftheCard: ${angleOftheCard}
    ''';
  }
}
