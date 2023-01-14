import 'package:flutter/material.dart';
import 'package:game_scan/widgets/game_scan_settings_button.dart';

PreferredSizeWidget gameScanAppBar({required Widget leading}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40),
    child: AppBar(
      leading: leading,
      actions: const [
        GameScanSettingsButton(),
      ],
    ),
  );
}
