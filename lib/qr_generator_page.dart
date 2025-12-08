// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';

// class QrGeneratorPage extends StatefulWidget {
//   const QrGeneratorPage({super.key});

//   @override
//   State<QrGeneratorPage> createState() => _QrGeneratorPageState();
// }

// class _QrGeneratorPageState extends State<QrGeneratorPage> {
//   final TextEditingController _textController = TextEditingController();
//   final ScreenshotController _screenshotController = ScreenshotController();
//   String qrData = '';
//   String selectedType = 'text';
//   final Map<String, TextEditingController> _controllers = {
//     'name': TextEditingController(),
//     'phone': TextEditingController(),
//     'email': TextEditingController(),
//     'url': TextEditingController(),
//   };

//   String _generateQrData() {
//     switch (selectedType) {
//       case 'contact':
//         return '''BEGIN:VCARD
//       VERSION:3.0
//       FN:${_controllers['name']?.text}
//       TEL:${_controllers['phone']?.text}
//       EMAIL:${_controllers['email']?.text}
//       END:VCARD''';

//       case 'url':
//         String url = _controllers['url']?.text ?? '';
//         if (!url.startsWith('http://') || !url.startsWith('https://')) {
//           url = 'https://$url';
//         }
//         return url;

//       default:
//         return _textController.text;
//     }
//   }

//   Future<void> _shareQRCode() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final imagePath = '${directory.path}/qr_code.png';
//     final capture = await _screenshotController.capture();
//     if (capture == null) return null;

//     File imageFile = File(imagePath);
//     await imageFile.writeAsBytes(capture);
//     await Share.shareXFiles([XFile(imagePath)], text: 'Share QR Code');
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),

//         onChanged: (_) {
//           setState(() {
//             qrData = _generateQrData();
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildInputFields() {
//     switch (selectedType) {
//       case 'contact':
//         return Column(
//           children: [
//             _buildTextField(_controllers['name']!, "Name"),
//             _buildTextField(_controllers['phone']!, "Phone"),
//             _buildTextField(_controllers['email']!, "Email"),
//           ],
//         );

//       case 'url':
//         return _buildTextField(_controllers['url']!, 'Url');

//       default:
//         return Padding(
//           padding: EdgeInsets.only(bottom: 16),
//           child: TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               labelText: 'Enter Text',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),

//             onChanged: (value) {
//               setState(() {
//                 qrData = value;
//               });
//             },
//           ),
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         title: Text("Generate QR Code", style: GoogleFonts.poppins()),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Card(
//                 color: Colors.white,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       SegmentedButton<String>(
//                         selected: {selectedType},
//                         onSelectionChanged: (Set<String> selection) {
//                           setState(() {
//                             selectedType = selection.first;
//                             qrData = '';
//                           });
//                         },
//                         segments: [
//                           ButtonSegment(
//                             value: 'text',
//                             label: Text("Text"),
//                             icon: Icon(Icons.text_fields),
//                           ),
//                           ButtonSegment(
//                             value: 'url',
//                             label: Text("URL"),
//                             icon: Icon(Icons.text_fields),
//                           ),
//                           ButtonSegment(
//                             value: 'contact',
//                             label: Text("Contact"),
//                             icon: Icon(Icons.contact_page),
//                           ),
//                           // ButtonSegment(
//                           //   value: 'text',
//                           //   label: Text("Text"),
//                           //   icon: Icon(Icons.text_fields),
//                           // ),
//                         ],
//                       ),
//                       SizedBox(height: 24),
//                       _buildInputFields(),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               if (qrData.isNotEmpty)
//                 Column(
//                   children: [
//                     Card(
//                       color: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Screenshot(
//                               controller: _screenshotController,
//                               child: Container(
//                                 color: Colors.white,
//                                 padding: EdgeInsets.all(16),
//                                 child: QrImageView(
//                                   data: qrData,
//                                   version: QrVersions.auto,
//                                   size: 200,
//                                   errorCorrectionLevel: QrErrorCorrectLevel.H,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton.icon(
//                       onPressed: _shareQRCode,
//                       icon: Icon(Icons.share),
//                       label: Text("Share QR Code"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrGeneratorPage extends StatefulWidget {
  const QrGeneratorPage({super.key});

  @override
  State<QrGeneratorPage> createState() => _QrGeneratorPageState();
}

class _QrGeneratorPageState extends State<QrGeneratorPage>
    with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController(
    // torchEnabled: true,        // вкл. фонарик по умолчанию (по желанию)
    formats: [BarcodeFormat.qrCode, BarcodeFormat.aztec, BarcodeFormat.dataMatrix],
  );

  bool _isTorchOn = false;  // Локальное состояние для иконки фонарика
  bool _isScanCompleted = false; // чтобы не срабатывало много раз

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        controller.stop();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanCompleted) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    setState(() => _isScanCompleted = true);

    // Показываем результат красиво
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ResultBottomSheet(
        scannedCode: code,
        onClose: () {
          Navigator.pop(context); // закрываем bottom sheet
          setState(() => _isScanCompleted = false);
          controller.start(); // продолжаем сканировать
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text("Scan QR Code", style: GoogleFonts.poppins()),
        centerTitle: true,
        actions: [
          // Кнопка фонарика (с локальным состоянием)
          IconButton(
            icon: Icon(
              _isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: _isTorchOn ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              setState(() => _isTorchOn = !_isTorchOn);
              controller.toggleTorch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Сам сканер (без overlay)
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),

          // Кастомный оверлей с рамкой (теперь через Stack)
          _buildScannerOverlay(),

          // Кнопка закрытия (если вдруг застрял)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text("Close"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Кастомный оверлей с рамкой (через Stack)
  Widget _buildScannerOverlay() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Уголки
            _corner(Alignment.topLeft),
            _corner(Alignment.topRight),
            _corner(Alignment.bottomLeft),
            _corner(Alignment.bottomRight),
          ],
        ),
      ),
    );
  }

  Widget _corner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: _CornerPainter(),
        ),
      ),
    );
  }
}

// Уголки рамки
class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, 15)
      ..lineTo(0, 0)
      ..lineTo(15, 0)
      ..moveTo(size.width - 15, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 15);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Красивый результат
class _ResultBottomSheet extends StatelessWidget {
  final String scannedCode;
  final VoidCallback onClose;

  const _ResultBottomSheet({
    required this.scannedCode,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 20),
          const Icon(Icons.qr_code_scanner, size: 80, color: Colors.indigo),
          const SizedBox(height: 16),
          Text(
            "QR Code Scanned!",
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SelectableText(
            scannedCode,
            style: GoogleFonts.robotoMono(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onClose();
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onClose,
                  icon: const Icon(Icons.done),
                  label: const Text("OK"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}