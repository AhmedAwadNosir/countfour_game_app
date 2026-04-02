import 'package:countfour_game_app/features/home_feature/presentations/widgets/cell.dart';
import 'package:countfour_game_app/features/home_feature/states_manager/controler/game_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardColumn extends StatelessWidget {
  BoardColumn({
    super.key,
    required this.columnOfPlayerChips,
    required this.columnNumber,
  });

  final GameControler gameControler = Get.find<GameControler>();
  final List<int> columnOfPlayerChips;
  final int columnNumber; // to get selected column number
  List<Cell> _buildBoardColumn() {
    return columnOfPlayerChips
        .reversed // this for making color state from down not from up
        .map(
          (number) =>
              number ==
                  1 //this for chaking number and return cell state acording to its number value in the list
              ? const Cell(currentCellMode: cellMode.Yellow)
              : number == 2
              ? const Cell(currentCellMode: cellMode.RED)
              : const Cell(currentCellMode: cellMode.Empty),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gameControler.playColumn(columnNumber); // to use methode for play
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildBoardColumn(),
        //  [
        //   Cell(),
        //   Cell(),
        //   Cell(),
        //   Cell(),
        //   Cell(),
        //   Cell(),
        // ],
      ),
    );
  }
}
