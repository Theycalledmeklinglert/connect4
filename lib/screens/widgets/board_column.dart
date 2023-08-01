import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';
import 'cell.dart';

class BoardColumn extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();
  late final List<int> coinsInColumn;

  BoardColumn({
    Key? key,
    required this.coinsInColumn,
  }) : super(key: key);

  List<Cell> _buildBoardColumn() {
    print(coinsInColumn.length);
    return coinsInColumn.map((chip) => Cell()).toList();
  }

  @override
  Widget build(BuildContext context) {
      return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildBoardColumn(),
    );
  }
}
