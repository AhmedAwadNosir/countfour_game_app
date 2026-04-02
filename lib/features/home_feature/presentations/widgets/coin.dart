import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  const Coin({
    super.key,
    required this.coinColor,
  });
  final Color coinColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: coinColor, borderRadius: BorderRadius.circular(42)),
    );
  }
}
