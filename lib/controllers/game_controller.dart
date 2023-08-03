import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
      print("Winner: $horizontalWinCond");
    }
    else {
      Get.snackbar("Not available", "This column is full already",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  int checkForHorizontalWin(int columnNumber) {
    int consecutiveYellows = 0;
    int consecutiveReds = 0;
    List<int> rowEntries = getRowAsList(columnNumber);

    for (var i = 0; i < rowEntries.length; i++) {
      if (rowEntries[i] == 1) {
        consecutiveYellows++;
        consecutiveReds = 0;
      }
      else if (rowEntries[i] == 2) {
        consecutiveReds++;
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
}
