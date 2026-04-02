import 'package:countfour_game_app/features/home_feature/presentations/widgets/cell.dart';
import 'package:countfour_game_app/features/home_feature/presentations/widgets/coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameControler extends GetxController {
  final RxList<List<int>> _board = RxList<List<int>>();
  set board(List<List<int>> value) =>
      _board.value = value; //this for set values of ever cell in game_board

  List<List<int>> get board =>
      _board.value; // this for returning values of every cell in game_board

  RxBool _turnYellow = true.obs; //this for defin which player has turn to play
  bool get turnYellow => _turnYellow
      .value; // to get value that define which player have trun to play

  void _buildBoard() {
    _turnYellow.value = true;
    board = [
      List.filled(
        6,
        0,
      ), // this is list of integer for every column in game board set value of each cell to 0
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
    ];
    update();
  }

  void playColumn(int columnNumber) {
    //this methode is resbonsable for when player tack action that method aply to colum chosen color of the player
    final int playerNumber = turnYellow
        ? 1
        : 2; // this for get player number to define the color of the coin
    final selectedColumn =
        board[columnNumber]; //this for define who is the column sected to make coin
    if (selectedColumn.contains(0)) {
      // to define if column has empty cell
      final int rowIndex = selectedColumn.indexWhere(
        (cell) => cell == 0,
      ); // to get first empty cell to change its color to player
      selectedColumn[rowIndex] =
          playerNumber; // changing cell is selected to color of the player
      _turnYellow.value =
          !_turnYellow.value; // changing the player have the turn to play
      update(); // to update ui

      // int resultHorizantal = checkHorizontals();
      // int resultVirtecals = checkVerticals();

      // //* to update ui when any of the player won with dialog show whos palyer when and rebuild ui
      // if (resultHorizantal == 1 || resultVirtecals == 1) {
      //   Get.defaultDialog(
      //     title: "YELLOW WON",
      //     content: Coin(coinColor: Colors.yellow),
      //   ).then((value) => _buildBoard());
      // } else if (resultHorizantal == 2 || resultVirtecals == 2) {
      //   Get.defaultDialog(
      //     title: "RED WON",
      //     content: Coin(coinColor: Colors.red),
      //   ).then((value) => _buildBoard());
      //   ;
      // }

      winner = checkVictory();

      if (winner != 0) {
        declareWinner();
      }

      if (boardIsFull()) {
        Get.defaultDialog(
          title: 'Draw! Nobody won.',
          content: Cell(currentCellMode: cellMode.Empty),
        ).then((value) => resetGame());
      }
    } else {
      Get.snackbar(
        'Not available',
        'this column is already filled up. choose another column', // to show snack par if column is filled up
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  int winner = 0;

  void declareWinner() {
    Get.defaultDialog(
      title: winner == 1 ? 'YELLOW WON' : 'RED WON',
      content: Cell(
        currentCellMode: winner == 1 ? cellMode.Yellow : cellMode.RED,
      ),
    ).then((value) => resetGame());
  }

  void resetGame() => _buildBoard();

  bool boardIsFull() {
    for (final col in board) {
      for (final val in col) {
        if (val == 0) {
          return false;
        }
      }
    }
    return true;
  }

  //* to check every cell in every row
  int checkHorizontals() {
    int yellowInRow = 0;
    int redInRow = 0;
    List<List<int>> rows = [];
    for (var i = 0; i < 6; i++) {
      final List<int> currentRow = getRowList(
        i,
      ); // for storing each row (with its cells) in current row
      rows.add(
        currentRow,
      ); // ading row to list of list of intg contain all row of its cells
    }

    //* to check every cell in every row
    for (final row in rows) {
      for (final cell in row) {
        if (yellowInRow >= 4) {
          return 1;
        } else if (redInRow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInRow++;
            redInRow = 0;
          } else if (cell == 2) {
            redInRow++;
            yellowInRow = 0;
          } else {
            yellowInRow = 0;
            redInRow = 0;
          }
        }
      }
    }
    return 0;
  }

  //*to get every cell in current row
  List<int> getRowList(int rowNumber) {
    List<int> rowList = [];
    for (final Column in board) {
      rowList.add(Column[rowNumber]);
    }
    return rowList;
  }

  //*to check every cell in every column
  int checkVerticals() {
    int yellowInRow = 0;
    int redInRow = 0;

    for (final column in board) {
      for (final cell in column) {
        if (yellowInRow >= 4) {
          return 1;
        } else if (redInRow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInRow++;
            redInRow = 0;
          } else if (cell == 2) {
            redInRow++;
            yellowInRow = 0;
          } else {
            yellowInRow = 0;
            redInRow = 0;
          }
        }
      }
    }
    return 0;
  }

  int checkDiagonals() {
    final List<int> diagonalDown1 = [];
    final List<int> diagonalDown2 = [];
    final List<int> diagonalDown3 = [];
    final List<int> diagonalDown4 = [];
    final List<int> diagonalDown5 = [];
    final List<int> diagonalDown6 = [];
    final List<int> diagonalUp1 = [];
    final List<int> diagonalUp2 = [];
    final List<int> diagonalUp3 = [];
    final List<int> diagonalUp4 = [];
    final List<int> diagonalUp5 = [];
    final List<int> diagonalUp6 = [];

    //* Fill list 1
    diagonalDown1.add(getCellValue(0, 3));
    diagonalDown1.add(getCellValue(1, 2));
    diagonalDown1.add(getCellValue(2, 1));
    diagonalDown1.add(getCellValue(3, 0));
    //* Fill list 2
    diagonalDown2.add(getCellValue(0, 4));
    diagonalDown2.add(getCellValue(1, 3));
    diagonalDown2.add(getCellValue(2, 2));
    diagonalDown2.add(getCellValue(3, 1));
    diagonalDown2.add(getCellValue(4, 0));
    //* Fill list 3
    diagonalDown3.add(getCellValue(0, 5));
    diagonalDown3.add(getCellValue(1, 4));
    diagonalDown3.add(getCellValue(2, 3));
    diagonalDown3.add(getCellValue(3, 2));
    diagonalDown3.add(getCellValue(4, 1));
    diagonalDown3.add(getCellValue(5, 0));
    //* Fill list 4
    diagonalDown4.add(getCellValue(1, 5));
    diagonalDown4.add(getCellValue(2, 4));
    diagonalDown4.add(getCellValue(3, 3));
    diagonalDown4.add(getCellValue(4, 2));
    diagonalDown4.add(getCellValue(5, 1));
    diagonalDown4.add(getCellValue(6, 0));
    //* Fill list 5
    diagonalDown5.add(getCellValue(2, 5));
    diagonalDown5.add(getCellValue(3, 4));
    diagonalDown5.add(getCellValue(4, 3));
    diagonalDown5.add(getCellValue(5, 2));
    //* Fill list 6
    diagonalDown6.add(getCellValue(3, 5));
    diagonalDown6.add(getCellValue(4, 4));
    diagonalDown6.add(getCellValue(5, 3));
    diagonalDown6.add(getCellValue(6, 2));
    //* Fill list 1
    diagonalUp1.add(getCellValue(0, 2));
    diagonalUp1.add(getCellValue(1, 2));
    diagonalUp1.add(getCellValue(2, 3));
    diagonalUp1.add(getCellValue(3, 4));
    //* Fill list 2
    diagonalUp2.add(getCellValue(0, 1));
    diagonalUp2.add(getCellValue(1, 2));
    diagonalUp2.add(getCellValue(2, 3));
    diagonalUp2.add(getCellValue(3, 4));
    diagonalUp2.add(getCellValue(4, 5));
    //* Fill list 3
    diagonalUp3.add(getCellValue(0, 0));
    diagonalUp3.add(getCellValue(1, 1));
    diagonalUp3.add(getCellValue(2, 2));
    diagonalUp3.add(getCellValue(3, 3));
    diagonalUp3.add(getCellValue(4, 4));
    diagonalUp3.add(getCellValue(5, 5));
    //* Fill list 4
    diagonalUp4.add(getCellValue(1, 0));
    diagonalUp4.add(getCellValue(2, 1));
    diagonalUp4.add(getCellValue(3, 2));
    diagonalUp4.add(getCellValue(4, 3));
    diagonalUp4.add(getCellValue(5, 4));
    diagonalUp4.add(getCellValue(6, 5));
    //* Fill list 5
    diagonalUp5.add(getCellValue(2, 0));
    diagonalUp5.add(getCellValue(3, 1));
    diagonalUp5.add(getCellValue(4, 2));
    diagonalUp5.add(getCellValue(5, 3));
    diagonalUp5.add(getCellValue(6, 4));
    // //* Fill list 6
    diagonalUp6.add(getCellValue(3, 0));
    diagonalUp6.add(getCellValue(4, 1));
    diagonalUp6.add(getCellValue(5, 2));
    diagonalUp6.add(getCellValue(6, 3));

    //* Diagonals Parent List
    List<List<int>> diagonals = [];
    diagonals.addAll([
      diagonalDown1,
      diagonalDown2,
      diagonalDown3,
      diagonalDown4,
      diagonalDown5,
      diagonalDown6,
      diagonalUp1,
      diagonalUp2,
      diagonalUp3,
      diagonalUp4,
      diagonalUp5,
      diagonalUp6,
    ]);

    for (final diagonal in diagonals) {
      final String diagonalStr = diagonal.join();
      if (diagonalStr.contains('1111')) {
        return 1;
      } else if (diagonalStr.contains('2222')) {
        return 2;
      }
    }

    return 0;
  }

  int getCellValue(int columnNumber, int rowNumber) {
    return board[columnNumber][rowNumber];
  }

  // for check all demntial
  int checkVictory() {
    //* Board dimensions
    const int maxx = 7;
    const int maxy = 6;
    List<List<int>> directions = [
      //* Horizontal to right
      [1, 0],
      //* Diagonal downwards
      [1, -1],
      //* Diagonal upwards
      [1, 1],
      //* Vertical upwards
      [0, 1],
    ];
    //* Direction loop
    for (List<int> d in directions) {
      int dx = d[0];
      int dy = d[1];
      //* Horizontal loop
      for (int x = 0; x < maxx; x++) {
        //* Vertical loop
        for (int y = 0; y < maxy; y++) {
          int lastx = (x + (3 * dx));
          int lasty = (y + (3 * dy));
          //* Check if current coordinates are within the board
          if ((((0 <= lastx) && (lastx < maxx)) && (0 <= lasty)) &&
              (lasty < maxy)) {
            //* Gets value of cell, starts always at (0,0)
            int w = board[x][y];
            //* Check for value equality of next three cells
            if ((((w != 0) && (w == board[x + dx][y + dy])) &&
                    (w == board[x + (2 * dx)][y + (2 * dy)])) &&
                (w == board[lastx][lasty])) {
              return w;
            }
          }
        }
      }
    }
    return 0;
  }

  @override
  void onInit() {
    _buildBoard(); // to initialize buildBoard methode when controler hade been inzialized
    super.onInit();
  }
}
