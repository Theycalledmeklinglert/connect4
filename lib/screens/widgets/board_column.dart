import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';
import 'cell.dart';

class BoardColumn extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();
  late final List<int> coinsInColumn;
  final int columnNumber;

  BoardColumn({
    Key? key,
    required this.coinsInColumn,
    required this.columnNumber,
  }) : super(key: key);

  List<Cell> _buildBoardColumn() {
    //print(coinsInColumn.length);
    return coinsInColumn.reversed
        .map((chip) => chip == 1
            ? Cell(currCellState: CellState.YELLOW)
            : chip == 2
                ? Cell(currCellState: CellState.RED)
                : Cell(currCellState: CellState.EMPTY))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          gameController.playColumn(columnNumber);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildBoardColumn(),
        ));
  }
}
