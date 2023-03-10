import 'package:flutter/material.dart';

class GameScanCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const GameScanCircularProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
      color: color ??
          (Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white));
}
