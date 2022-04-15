// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/components/animatedCard.dart';
import 'package:wordflow/core/components/gameFinishedCard.dart';
import 'package:wordflow/core/components/text/hintText.dart';
import 'package:wordflow/core/extensions/context_extension.dart';

import 'package:wordflow/view/menu/menu_viewmodel.dart';
import '/core/base/state/base_state.dart';
import '/core/base/view/base_view.dart';
import 'game_single_viewmodel.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends BaseState<GameView> {
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
        gameViewModel.getModelAndFillData();
      },
      onPageBuilder: (context) => buildScaffold(),
    );
  }

  Widget buildScaffold() => Observer(builder: (_) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hintTextWithPadding(),
                  Expanded(
                    child: boardCards(),
                  )
                ],
              ),
            ),
            if (gameViewModel.isGameFinished)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(context.highPadding),
                  child: GameFinishedCard(
                      continueClick: () {},
                      retryClick: () {},
                      homeClick: () {
                        gameViewModel.changeGameStatus();
                        context.read<MenuViewModel>().changeStatus(MenuState.main);
                      }),
                )),
              ),
          ],
        );
      });

  Padding hintTextWithPadding() {
    return Padding(
      padding: EdgeInsets.all(context.highPadding),
      child: Observer(builder: (_) {
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
}
