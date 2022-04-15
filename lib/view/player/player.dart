class Player {
  final String? _name;
  int _score = 0;

  Player(this._name);

  String? get getName {
    return _name;
  }

  int get getScore {
    return _score;
  }

  void setScore(int score) {
    _score = score;
  }
}
