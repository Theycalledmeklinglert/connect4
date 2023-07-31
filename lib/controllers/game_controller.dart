import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GameController extends GetxController {
  RxList<List<int>> _board = RxList<List<int>>();
  List<List<int>> get board => _board.value;
  set board (List<List<int>> value) => _board.value = value;

  void _buildBoard() {
    board = [
      List.filled(6,0),
      List.filled(6,0),
      List.filled(6,0),
      List.filled(6,0),
      List.filled(6,0),
      List.filled(6,0),
      List.filled(6,0),
    ];
  }

  @override
  onInit() {
    super.onInit();
    _buildBoard();
  }
}