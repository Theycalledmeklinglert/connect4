import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nao_connect_4/controllers/game_controller.dart';
import 'package:nao_connect_4/screens/widgets/board_column.dart';

class Board extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();

  List<BoardColumn> _buildBoard() {
    int currentColNumber = 0;
    return gameController.board
        .map((boardColumn) => BoardColumn(
              coinsInColumn: boardColumn,
              columnNumber: currentColNumber++,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
          ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetBuilder<GameController>(
                      builder: (GetxController gameController) => Row(
                        children: _buildBoard(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ],
    );
  }
}
