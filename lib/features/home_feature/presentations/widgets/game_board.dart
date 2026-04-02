import 'package:countfour_game_app/features/home_feature/presentations/widgets/board_column.dart';
import 'package:countfour_game_app/features/home_feature/states_manager/controler/game_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameBoard extends StatelessWidget {
  GameBoard({super.key});

  final GameControler gameControler =
      Get.find<GameControler>(); // for use game controler
  List<BoardColumn> _buildBoard() {
    int currentColumnNubmer = 0; // intial number for first column
    return gameControler.board
        .map(
          (boardcolumn) => BoardColumn(
            columnOfPlayerChips: boardcolumn,
            columnNumber: currentColumnNubmer++, // to path column number
          ),
        )
        .toList(); // for getting board columns
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<GameControler>(
                // to rebiuld ui when user take action
                builder: (controller) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildBoard(),
                  // [
                  //   BoardColumn(),
                  //   BoardColumn(),
                  //   BoardColumn(),
                  //   BoardColumn(),
                  //   BoardColumn(),
                  //   BoardColumn(),
                  //   BoardColumn(),
                  // ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
