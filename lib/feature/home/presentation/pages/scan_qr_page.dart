import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart' as contacts;
import 'package:flutter_contacts/properties/email.dart' as contacts;
import 'package:flutter_contacts/properties/phone.dart' as contacts;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQrPage extends StatefulWidget {
  ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  bool hasPermission = false;
  bool isFlashOn = false;

  late MobileScannerController mobileScannerController;

  @override
  void initState() {
    super.initState();
    mobileScannerController = MobileScannerController();
    _checkPermission();
  }

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasPermission = status.isGranted;
    });
  }

  Future<void> _processScanedData(String? data) async {
    if (data == null) return;

    mobileScannerController.stop();

    String type = "text";

    if (data.startsWith('BEGIN:VCARD')) {
      type = 'contact';
    } else if (data.startsWith('https://') || data.startsWith('http://')) {
      type = 'url';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: EdgeInsets.all(22),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: EdgeInsets.only(bottom: 24),

                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Text(
                      "Scanned Result:",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    SizedBox(height: 16),

                    Text(
                      "Type: ${type.toUpperCase()}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              data,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),

                            SizedBox(height: 24),
                            if (type == 'url')
                              ElevatedButton.icon(
                                onPressed: () {
                                  // _launchUrl(data);
                                },
                                icon: Icon(Icons.open_in_new),
                                label: Text("Open URL"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50),
                                ),
                              ),

                            if (type == 'contact')
                              ElevatedButton.icon(
                                onPressed: () {
                                  // _saveContact(data);
                                },
                                icon: Icon(Icons.open_in_new),
                                label: Text("Save Contact"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Share.share(data);
                            },
                            icon: Icon(Icons.share),
                            label: Text("Share"),
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              mobileScannerController.start();
                            },
                            icon: Icon(Icons.qr_code_scanner),
                            label: Text("Scan Again"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _saveContact(String vcardData) async {
    final lines = vcardData.split('\n');
    String? phone, name, email;

    for (var line in lines) {
      if (line.startsWith("FN:")) name = line.substring(3);
      if (line.startsWith("TEL:")) name = line.substring(4);
      if (line.startsWith("FN:")) name = line.substring(5);
    }

    final contact =
        contacts.Contact()
          ..name.first = name ?? ''
          ..phones = [contacts.Phone(phone ?? '')]
          ..emails = [contacts.Email(phone ?? '')];

    try {
      await contact.insert();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Contact Saved!")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasPermission) {
      return Scaffold(
        backgroundColor: Colors.indigo,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 350,
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _checkPermission,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Grant permission"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      //if permission is granted you can start scanning
      return Scaffold(
        backgroundColor: Colors.indigo,

        // appBar: AppBar(
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.indigo,

        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           isFlashOn = !isFlashOn;
        //           mobileScannerController.toggleTorch();
        //         });
        //       },
        //       icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
        //     ),
        //   ],
        // ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            MobileScanner(
              controller: mobileScannerController,
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                if (barcode.rawValue != null) {
                  final String code = barcode.rawValue!;
                  _processScanedData(code);
                }
              },
            ),

            // Затемнение вокруг центральной области
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.srcOut,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 330,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Рамка с углами
            Center(
              child: CustomPaint(
                size: Size(330, 300),
                painter: _ScannerBorderPainter(),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // setState(() {
                    //   isFlashOn = !isFlashOn;
                    //   mobileScannerController.toggleTorch();
                    // });
                  },
                  icon: Icon(Icons.close, size: 35, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                      mobileScannerController.toggleTorch();
                    });
                  },
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Text(
                      "Align QR Code within the frame",
                      style: TextStyle(
                        color: Colors.white,
                        // backgroundColor: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _ScannerBorderPainter extends CustomPainter {
  final Paint borderPaint =
      Paint()
        ..color = Colors.greenAccent
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    const double cornerLength = 30;
    final double width = size.width;
    final double height = size.height;

    final path =
        Path()
          ..moveTo(0, cornerLength)
          ..lineTo(0, 0)
          ..lineTo(cornerLength, 0)
          ..moveTo(width - cornerLength, 2)
          ..lineTo(width, 0)
          ..lineTo(width, cornerLength)
          ..moveTo(0, height - cornerLength)
          ..lineTo(0, height)
          ..lineTo(cornerLength, height)
          ..moveTo(width - cornerLength, height)
          ..lineTo(width, height)
          ..lineTo(width, height - cornerLength);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
