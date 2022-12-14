import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_scan/widgets/game_scan_back_button.dart';

class GameScanPage extends StatefulWidget {
  static const String route = 'game-scan';

  const GameScanPage({Key? key}) : super(key: key);

  @override
  State<GameScanPage> createState() => _GameScanPageState();
}

class _GameScanPageState extends State<GameScanPage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraController;

  @override
  void initState() {
    _initializeCameraController = _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription camera = cameras.first;
    _cameraController = CameraController(camera, ResolutionPreset.high);
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _initializeCameraController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _cameraController,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle:
                      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                  elevation: 0,
                  leading: const BackButton(),
                ),
                floatingActionButton: IconButton(
                  icon: const Icon(Icons.circle_outlined),
                  color: Colors.white,
                  iconSize: 75,
                  onPressed: () => null,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
