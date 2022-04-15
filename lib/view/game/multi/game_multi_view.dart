// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/animatedCard.dart';
import 'package:wordflow/core/components/gameFinishedCard.dart';
import 'package:wordflow/core/components/text/hintText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';
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
        // gameViewModel.getModelAndFillData();
        gameViewModel.socketConnect();
      },
      onPageBuilder: (context) => SafeArea(child: buildScaffold()),
    );
  }

  Widget buildScaffold() => Observer(builder: (_) {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (gameViewModel.isGameStarted)
              Container(
                color: Colors.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(gameViewModel.round.toString()),
                      ),
                      Expanded(
                        child: Text(gameViewModel.player2.getName!),
                      )
                    ]),
                    hintTextWithPadding(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: boardCards(),
                      ),
                    )
                  ],
                ),
              )
            else if (gameViewModel.isGameFinished)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(context.highPadding),
                  child: GameFinishedCard(
                      continueClick: () {},
                      retryClick: () {},
                      homeClick: () {
                        //gameViewModel.changeGameStatus();
                        context.read<MenuViewModel>().changeStatus(MenuState.main);
                      }),
                )),
              )
            else
              const InQueueView()
          ],
        );
      });

  Padding hintTextWithPadding() {
    return Padding(
      padding: EdgeInsets.all(context.highPadding),
      child: Observer(builder: (_) {
        //return const Text('');
        return HintText(text: gameViewModel.board.currentHint);
      }),
    );
  }

  GridView boardCards() {
    return GridView.count(
      primary: false,
      crossAxisCount: 4,
      childAspectRatio: 2.4 / 2.3,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
          context.extraLowPadding, context.extraHighPadding, context.extraLowPadding, context.extraLowPadding),
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < gameViewModel.cardListStatus.length; i++)
          Padding(
            padding: EdgeInsets.all(context.extraLowPadding),
            child: AnimatedCard(
              cardStatus: gameViewModel.cardListStatus[gameViewModel.board.allWords[i]]!,
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
