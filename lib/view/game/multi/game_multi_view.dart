// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/alertCard.dart';
import 'package:wordflow/core/components/animatedCard.dart';
import 'package:wordflow/core/components/gameFinishedCard.dart';
import 'package:wordflow/core/components/text/hintText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
import 'package:wordflow/view/animeted.dart';
import 'package:wordflow/view/game/multi/inqueue_view.dart';

import 'package:wordflow/view/menu/menu_viewmodel.dart';
import '../single/game_single_viewmodel.dart';
import '/core/base/state/base_state.dart';
import '/core/base/view/base_view.dart';
import 'game_multi_viewmodel.dart';

class GameMultiView extends StatefulWidget {
  const GameMultiView({Key? key}) : super(key: key);
  @override
  _GameMultiViewState createState() => _GameMultiViewState();
}

class _GameMultiViewState extends BaseState<GameMultiView> {
  late GameMultiViewModel gameViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (context, model) {
        gameViewModel = model as GameMultiViewModel;
        gameViewModel.context = context;
      },
      viewModel: GameMultiViewModel(),
      onInitState: () {
        gameViewModel.socketConnect();
      },
      onPageBuilder: (context) => SafeArea(child: buildScaffold()),
    );
  }

  Widget buildScaffold() => Observer(builder: (_) {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (gameViewModel.gameStatus == GameStatus.initializing) InQueueView(model: gameViewModel),
            if (gameViewModel.gameStatus == GameStatus.started ||
                gameViewModel.gameStatus == GameStatus.stopped ||
                gameViewModel.gameStatus == GameStatus.finished)
              Stack(
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
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(context.lowPadding),
                                child: const Image(
                                  image: AssetImage('assets/icons/close_rect.png'),
                                ),
                              ),
                              onTap: () {
                                gameViewModel.handleDisconnect('data');
                                context.read<MenuViewModel>().changeStatus(MenuState.main);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(context.lowPadding),
                                    child: Anim(title: 'a', vm: gameViewModel),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      gameViewModel.turnText(),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            const Expanded(flex: 1, child: Text('YOU')),
                                            Expanded(flex: 1, child: Text(gameViewModel.player.getScore.toString())),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(flex: 1, child: hintTextWithPadding()),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            const Expanded(flex: 1, child: Text('OPPONENT')),
                                            Expanded(flex: 1, child: Text(gameViewModel.opponentScore.toString())),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.all(context.normalPadding),
                            child: boardCards(),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (gameViewModel.gameStatus == GameStatus.stopped)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(context.highPadding),
                        child: AlertCard(
                            continueClick: () {},
                            retryClick: () {},
                            homeClick: () {
                              //gameViewModel.changeGameStatus();
                              context.read<MenuViewModel>().changeStatus(MenuState.main);
                            }),
                      )),
                    ),
                  if (gameViewModel.gameStatus == GameStatus.finished)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.all(context.highPadding),
                        child: GameFinishedCard(
                            score: gameViewModel.player.getScore,
                            opponentScore: gameViewModel.opponentScore,
                            continueClick: () {},
                            retryClick: () {},
                            homeClick: () {
                              gameViewModel.handleDisconnect('data');
                              context.read<MenuViewModel>().changeStatus(MenuState.main);
                            }),
                      )),
                    ),
                ],
              ),
          ],
        );
      });

  Padding hintTextWithPadding() {
    return Padding(
      padding: EdgeInsets.all(context.lowPadding),
      child: Observer(builder: (_) {
        //return const Text('');
        return HintText(text: gameViewModel.board.currentHint);
      }),
    );
  }

  GridView boardCards() {
    double cardWidth = context.dynamicWidth(0.42);
    double cardHeight = context.dynamicHeight(0.108);
    return GridView.count(
      primary: false,
      crossAxisCount: 3,
      childAspectRatio: cardWidth / cardHeight,
      physics: const NeverScrollableScrollPhysics(),

      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < gameViewModel.cardStatusList.length; i++)
          Padding(
            padding: EdgeInsets.all(context.extraLowPadding),
            child: AnimatedCard(
              whoClickedplayerId: gameViewModel.cardStatusList[i].playerId,
              currentPlayerId: gameViewModel.socket.id.toString(),
              isMultiplayer: true,
              cardStatus:
                  gameViewModel.cardStatusList[i].status!, //gameViewModel.cardListStatus[gameViewModel.board.allWords[i]]!,
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
}
