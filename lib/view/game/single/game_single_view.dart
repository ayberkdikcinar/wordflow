// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/animatedCard.dart';
import 'package:wordflow/core/components/gameFinishedCard.dart';
import 'package:wordflow/core/components/text/hintText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

import 'package:wordflow/view/menu/menu_viewmodel.dart';
import 'package:wordflow/view/wordsRelation/model/words_relation_model.dart';
import '../multi/game_multi_viewmodel.dart';
import '/core/base/state/base_state.dart';
import '/core/base/view/base_view.dart';
import 'game_single_viewmodel.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends BaseState<GameView> {
  // ignore: prefer_typing_uninitialized_variables
  late GameSingleViewModel gameViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (context, model) {
        gameViewModel = model as GameSingleViewModel;
        gameViewModel.context = context;
      },
      viewModel: GameSingleViewModel(),
      onInitState: () {
        Future.delayed(Duration.zero, () async {
          bool response = await asyncMethod();
          debugPrint(response.toString());
          if (response) {
            gameViewModel.gameStatus = GameStatus.started;
          } else {
            gameViewModel.gameStatus = GameStatus.stopped;
          }
        });
      },
      onPageBuilder: (context) => buildScaffold(),
    );
  }

  Widget buildScaffold() => Observer(builder: (_) {
        if (gameViewModel.gameStatus == GameStatus.started || gameViewModel.gameStatus == GameStatus.finished) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: const Color.fromARGB(255, 34, 40, 49),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: closeRectContainer(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(context.lowPadding),
                                child: Text(
                                    'Find ${gameViewModel.board.wordsRelationList[gameViewModel.round].totalCount} words related with the given clue;'),
                              )),
                          Expanded(flex: 2, child: hintTextWithPadding()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.all(context.highPadding),
                        child: boardCards(),
                      ),
                    )
                  ],
                ),
              ),
              if (gameViewModel.gameStatus == GameStatus.finished) gameFinishedContainer()
            ],
          );
        }
        // ignore: curly_braces_in_flow_control_structures
        if (gameViewModel.gameStatus == GameStatus.stopped) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      context.read<MenuViewModel>().changeStatus(MenuState.main);
                    },
                    child: const Text('AN ERROR HAS BEEN OCCURRED'))
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(color: Colors.white));
        /*return FutureBuilder<List<WordsRelation>>(
          future: gameViewModel.getDataFromAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } else {
              if (snapshot.hasData) {
                gameViewModel.getModelAndFillData(snapshot.data!);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if (gameViewModel.gameStatus == GameStatus.finished) gameFinishedContainer(),
                    Container(
                      color: const Color.fromARGB(255, 34, 40, 49),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: closeRectContainer(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(context.lowPadding),
                                      child: Text(
                                          'Find ${gameViewModel.board.wordsRelationList[gameViewModel.round].totalCount} words related with the given clue;'),
                                    )),
                                Expanded(flex: 2, child: hintTextWithPadding()),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Padding(
                              padding: EdgeInsets.all(context.highPadding),
                              child: boardCards(),
                            ),
                          )
                        ],
                      ),
                    ),
                    //if (gameViewModel.gameStatus == GameStatus.finished) gameFinishedContainer(),
                  ],
                );
              } else {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            }
          },
        );*/
      });

  Container gameFinishedContainer() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(context.highPadding),
        child: GameFinishedCard(
            score: gameViewModel.player.getScore,
            continueClick: () {},
            retryClick: () {
              context.read<MenuViewModel>().changeStatus(MenuState.play);
            },
            homeClick: () {
              gameViewModel.gameStatus = GameStatus.finished;
              context.read<MenuViewModel>().changeStatus(MenuState.main);
            }),
      )),
    );
  }

  Container closeRectContainer() {
    return Container(
      alignment: Alignment.topLeft,
      child: InkWell(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/icons/close_rect.png'),
          ),
        ),
        onTap: () {
          gameViewModel.gameStatus = GameStatus.finished;
          context.read<MenuViewModel>().changeStatus(MenuState.main);
        },
      ),
    );
  }

  Padding hintTextWithPadding() {
    return Padding(
      padding: EdgeInsets.all(context.lowPadding),
      child: Observer(builder: (_) {
        return HintText(text: gameViewModel.board.currentHint);
      }),
    );
  }

  Widget boardCards() {
    double cardWidth = context.dynamicWidth(0.4);
    double cardHeight = context.dynamicHeight(0.108);
    return GridView.count(
      primary: false,
      crossAxisCount: 3,
      childAspectRatio: cardWidth / cardHeight,
      physics: const NeverScrollableScrollPhysics(),

      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < gameViewModel.board.allWords.length; i++)
          Padding(
            padding: EdgeInsets.all(context.extraLowPadding),
            child: AnimatedCard(
              cardStatus: 0,
              text: gameViewModel.board.allWords[i],
              onClickCallBack: (String text) {
                ClickResponse response = gameViewModel.cardClicked(text);
                return response;
              },
            ),
          ),
      ],
    );
  }

  Future<bool> asyncMethod() async {
    return Future(() async {
      return gameViewModel.getDataFromAPI();
    });
  }
}
