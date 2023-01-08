import 'package:flutter/material.dart';

class GameScanBackButton extends StatelessWidget {
  const GameScanBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
  }
}
