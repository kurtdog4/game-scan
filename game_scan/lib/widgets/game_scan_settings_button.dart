import 'package:flutter/material.dart';

class GameScanSettingsButton extends StatelessWidget {
  const GameScanSettingsButton(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => null,
      icon: Icon(
        Icons.settings,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}
