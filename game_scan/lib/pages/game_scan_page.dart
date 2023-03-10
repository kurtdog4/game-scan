import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:game_scan/models/boardgame.dart';
import 'package:game_scan/pages/game_scan_results.dart';
import 'package:game_scan/pages/rap_sheet_page.dart';
import 'package:game_scan/services/game_scan_api.dart';
import 'package:game_scan/widgets/game_scan_app_bar.dart';
import 'package:game_scan/widgets/game_scan_circular_progress_indicator.dart';

class GameScanPage extends StatefulWidget {
  static const String route = 'game-scan';

  GameScanPage({Key? key}) : super(key: key);

  @override
  State<GameScanPage> createState() => _GameScanPageState();
}

class _GameScanPageState extends State<GameScanPage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraController;
  File? _picture;

  @override
  void initState() {
    _initializeCameraController = _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription camera = cameras.first;
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final IconButton takePictureButton = IconButton(
      icon: const Icon(Icons.circle_outlined),
      color: Colors.white,
      iconSize: 75,
      onPressed: _takePicture,
    );

    return FutureBuilder(
      future: _initializeCameraController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              SizedBox.expand(
                child: CameraPreview(
                  _cameraController,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: gameScanAppBar(
                      context,
                      color: Colors.transparent,
                      iconColor: Colors.white,
                      statusBarIconBrightness: Brightness.light,
                      disableSettingsButton: true,
                    ),
                    floatingActionButton: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? takePictureButton
                        : null,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    body: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: takePictureButton)
                        : null,
                  ),
                ),
              ),
              _picture != null
                  ? SizedBox.expand(
                      child: Stack(
                        children: [
                          Image.file(
                            File(_picture!.path),
                            fit: BoxFit.cover,
                            color: Colors.black.withOpacity(.6),
                          ),
                          const Center(
                              child: GameScanCircularProgressIndicator(
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        } else {
          return const Center(child: GameScanCircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _takePicture() async {
    XFile picture = await _cameraController.takePicture();
    _picture = File(picture.path);
    setState(() {});
    Boardgame? boardgame = await getBoardgameListFromImageFile(_picture!);
    _picture = null;
    if (mounted) {
      Navigator.of(context).pushNamed(RapSheetPage.route,
          arguments: RapSheetPageArgs(boardgame!.spudID, boardgame.geekID!));
    }
  }
}
