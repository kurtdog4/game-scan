import 'package:flutter/material.dart';

class GameScanGameScanCircularProgressIndicator extends StatelessWidget {
  const GameScanGameScanCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white);
}
