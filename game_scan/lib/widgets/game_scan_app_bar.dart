import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_scan/widgets/game_scan_settings_button.dart';

PreferredSizeWidget gameScanAppBar(
  BuildContext context, {
  Color? color,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40),
    child: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      shadowColor: Colors.transparent,
      leading: Navigator.of(context).canPop()
          ? const BackButton()
          : Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Theme.of(context).brightness == Brightness.light
                  ? Image.asset('assets/GSLogoBlack.png')
                  : Image.asset('assets/GSLogoWhite.png'),
            ),
      actions: [
        GameScanSettingsButton(context),
      ],
    ),
  );
}
