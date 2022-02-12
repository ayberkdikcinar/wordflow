import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/init/theme/theme_manager.dart';
import '/core/base/state/base_state.dart';
import '/core/base/view/base_view.dart';
import 'viewmodel/main_viewmodel.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  late MainViewModel mainViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (context, model) {
        mainViewModel = model as MainViewModel;
        mainViewModel.context = context;
      },
      viewModel: MainViewModel(),
      onPageBuilder: (context) => buildScaffold(),
    );
  }

  Scaffold buildScaffold() => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(
                builder: (_) => TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: 0, end: mainViewModel.angleOftheCard),
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, double val, __) {
                    if (val >= (pi / 2)) {
                      mainViewModel.isCardFace = CardFace.back;
                    } else {
                      mainViewModel.isCardFace = CardFace.front;
                    }
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(val),
                      // ignore: sized_box_for_whitespace
                      child: InkWell(
                        onTap: () {
                          mainViewModel.setCurrentAngleOfCard();
                          debugPrint('Clicked');
                        },
                        child: SizedBox(
                          height: 300,
                          width: 200,
                          child: mainViewModel.isCardFace == CardFace.front
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/card/front.png")),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image:
                                            AssetImage("assets/card/back.png")),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
