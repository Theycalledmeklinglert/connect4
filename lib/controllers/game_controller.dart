import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/widgets/cell.dart';

class GameController extends GetxController {
  RxList<List<int>> _board = RxList<List<int>>();
  List<List<int>> get board => _board.value;
  set board(List<List<int>> value) => _board.value = value;
  RxBool _turnYellow = true.obs;
  bool get turnYellow => _turnYellow.value;

  void _buildBoard() {
    this.board = [
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _buildBoard();
  }

  void playColumn(int columnNumber) {
    final int playerNumber = turnYellow ? 1 : 2;
    if (board[columnNumber].contains(0)) {
      final int row = board[columnNumber].indexWhere((cell) => cell == 0);
      board[columnNumber][row] = playerNumber;
      _turnYellow.value = !_turnYellow.value;
      update();

      int horizontalWinCond = checkForHorizontalWin(columnNumber);
      int verticalWinCond = checkForVerticalWin(columnNumber);
      int diagonalWinCond = checkDiagonalWinCond(columnNumber);
      print("Horizontal Winner: $horizontalWinCond");
      print("Vertical Winner: $verticalWinCond");

      int winner = (horizontalWinCond != 0) ? horizontalWinCond : (verticalWinCond != 0) ? verticalWinCond : (diagonalWinCond != 0) ? diagonalWinCond : 0;

      if(winner != 0) {
        declareWinner(winner);
      }

      if(checkForFullBoard() == 1) {
        int fB = checkForFullBoard();
        print("FullBoard: $fB");
        showFullBoardDialog();
      }
    }
    else {
      Get.snackbar("Not available", "This column is full already",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void showFullBoardDialog() {
    final RxBool buttonVisible = true.obs;
    final GlobalKey<State> _dialogKey = GlobalKey<State>();

    Get.dialog(
      AlertDialog(
        key: _dialogKey,
        title: Text('Draw'),
        content: Obx(
              () => buttonVisible.value
              ? TextButton(
            onPressed: () {
              _buildBoard();
              buttonVisible.value = false;
              Get.back(id: _dialogKey.currentContext!.hashCode);
            },
            child: Text('OK'),
          )
              : SizedBox(),
        ),
      ),
    );
      }

  int checkForFullBoard() {
    for (List<int> elem in board) {
      for (int cell in elem) {
        if (cell == 0) {
          return 0;
        }
      }
    }
    return 1;
  }

  void declareWinner(int winner) {
    Get.defaultDialog(
        title: winner == 1 ? 'Player 1 (yellow) won' : 'Player 2 (red) won',
        content: Cell(
          currCellState: winner == 1 ? CellState.YELLOW : CellState.RED,
        )).then((value) => _buildBoard());
  }

  int checkForVerticalWin(int columnNumber) {
    List<int> column = board[columnNumber];
    return checkForConsecutiveNumber(column);
  }

  int checkForHorizontalWin(int columnNumber) {
    List<int> rowEntries = getRowAsList(columnNumber);
    return checkForConsecutiveNumber(rowEntries);
  }

  int checkForConsecutiveNumber(List<int> list) {
    int consecutiveYellows = 0;
    int consecutiveReds = 0;

    for (var i = 0; i < list.length; i++) {
      if(consecutiveYellows >= 4 || consecutiveReds >= 4) {
        break;
      }
      if (list[i] == 1) {
        consecutiveYellows++;
        consecutiveReds = 0;
      }
      else if (list[i] == 2) {
        consecutiveReds++;
        consecutiveYellows = 0;
      }
      else {
        consecutiveReds = 0;
        consecutiveYellows = 0;
      }
    }
    if(consecutiveYellows >= 4) {
      return 1;
    }
    else if(consecutiveReds >= 4) {
      return 2;
    }
    else {
      return 0;
    }
  }

  List<int> getRowAsList(int columnNumber) {
    List<int> colm = board[columnNumber].reversed.toList();
    print("Column: $colm");
    int rowIndex = (board[columnNumber].length - 1) - board[columnNumber].reversed.toList().indexWhere((cell) => cell != 0);
    List<int> rowEntries = [];
    board.forEach((column) => rowEntries.add(column[rowIndex]));
    print("row: $rowEntries");

    return rowEntries;
  }

  int checkDiagonalWinCond(int columnNumber) {
    int columnMax = 6; //max indices of the lists representing the field
    int rowMax = 5;    //max indices of the lists representing the field
    int rowIndex = (board[columnNumber].length - 1) - board[columnNumber].reversed.toList().indexWhere((cell) => cell != 0);

    List<int> upwardsDiagonal = getUpwardsDiagonalAsList(columnNumber, rowIndex, columnMax, rowMax);
    List<int> downwardsDiagonal = getDownwardsDiagonalAsList(columnNumber, rowIndex, columnMax, rowMax);

    return checkForConsecutiveNumber(upwardsDiagonal) != 0 ? checkForConsecutiveNumber(upwardsDiagonal) : checkForConsecutiveNumber(downwardsDiagonal);
  }

  List<int> getDownwardsDiagonalAsList(int columnNumber, int rowIndex, int columnMax, int rowMax) {
    List<int> downwardsDiagonal = [board[columnNumber][rowIndex]];
    int colCounter = columnNumber;
    int rowCounter = rowIndex;

    colCounter = columnNumber;
    rowCounter = rowIndex ;
    while(colCounter > 0 && rowCounter < rowMax) {            //links oben
      colCounter--;
      rowCounter++;
      List<int> curColumn = board[colCounter];
      downwardsDiagonal.insert(0, curColumn[rowCounter]);
    }

    colCounter = columnNumber;
    rowCounter = rowIndex ;
    while(colCounter < columnMax && rowCounter > 0) {            //rechts unten
      colCounter++;
      rowCounter--;
      List<int> curColumn = board[colCounter];
      downwardsDiagonal.add(curColumn[rowCounter]);
    }

    print("DownardsDiagonal: $downwardsDiagonal");

    return downwardsDiagonal;
  }

    List<int> getUpwardsDiagonalAsList(int columnNumber, int rowIndex, int columnMax, int rowMax) {
    List<int> upwardsDiagonal = [board[columnNumber][rowIndex]];

    int colCounter = columnNumber;
    int rowCounter = rowIndex;
    while(colCounter < columnMax && rowCounter < rowMax) {  //rechts oben
      colCounter++;
      rowCounter++;
      List<int> curColumn = board[colCounter];
      upwardsDiagonal.add(curColumn[rowCounter]);
    }

    colCounter = columnNumber;
    rowCounter = rowIndex ;
    while(colCounter > 0 && rowCounter > 0) {               //links unten
      colCounter--;
      rowCounter--;
      List<int> curColumn = board[colCounter];
      upwardsDiagonal.insert(0, curColumn[rowCounter]);
    }

    print("UpwardsDiagonal: $upwardsDiagonal");

    return upwardsDiagonal;
  }


}
