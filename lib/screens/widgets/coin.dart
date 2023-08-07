import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final Color coinColor;

  const Coin({
    Key? key,
    required this.coinColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80), color: coinColor),
    );
  }
}
