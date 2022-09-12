
import 'package:cinema_mobile/src/core/connection/cupon_connector.dart';
import 'package:cinema_mobile/src/custom/progress_hud.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/screens/home_screen.dart';

import 'package:cinema_mobile/src/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCameraPage extends StatefulWidget {
  const QrCameraPage({Key? key}) : super(key: key);

  @override
  _QrCameraPageState createState() => _QrCameraPageState();
}

bool isQrScanned = false;

class _QrCameraPageState extends State<QrCameraPage>
    with SingleTickerProviderStateMixin {
  late ProgressHUD2 loading;
  String? barcode;
  final CuponConnector cuponConnector = CuponConnector();
  bool isLoading = false;
  MobileScannerController controller = MobileScannerController(
      torchEnabled: false, formats: [BarcodeFormat.qrCode]
      // facing: CameraFacing.front,
      );

  bool isStarted = true;
  @override
  void initState() {
    super.initState();
    loading = initializeLoading('Registrando Cupon...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                // allowDuplicates: true,
                // controller: MobileScannerController(
                //   torchEnabled: true,
                //   facing: CameraFacing.front,
                // ),
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue;
                    onClickSendQr();
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: () => setState(() {
                          isStarted ? controller.stop() : controller.start();
                          isStarted = !isStarted;
                        }),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(Icons.camera_front);
                            }
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.switchCamera(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barcode found!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              await onClickSendQr();
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  onClickSendQr() {
    cuponConnector.addPointsCupon(barcode!).then((value) async {
      showSuccessAlert(context, value);
      isQrScanned = true;
    }).catchError((error) {
      String response = error;
      showErrorAlert(context, response);
    }).whenComplete(() {
      setState(() => isLoading = false);
    });
  }

  void showSuccessAlert(BuildContext context, ApiResponse response) {
    DialogUtils.showAlert(context, response.message!, <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        },
        child: const Text('Aceptar'),
      ),
    ]);
  }

  void showErrorAlert(BuildContext context, String error) {
    DialogUtils.showAlert(context, error, <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
        child: const Text('Aceptar'),
      ),
    ]);
  }
}
