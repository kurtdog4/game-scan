import 'package:flutter/material.dart';
import 'package:game_scan/widgets/game_scan_settings_button.dart';

PreferredSizeWidget gameScanAppBar({required Widget leading, Color? color, double size = 40}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(size),
    child: AppBar(
      backgroundColor: color,
      shadowColor: Colors.transparent,
      leading: leading,
      actions: const [
        GameScanSettingsButton(),
      ],
    ),
  );
}