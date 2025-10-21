import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khizmat_new/feature/home/presentation/pages/scan_qr_page.dart';
import 'package:khizmat_new/qr_generator_page.dart';
class QrMainPage extends StatefulWidget {
  const QrMainPage({super.key});

  @override
  State<QrMainPage> createState() => _QrMainPageState();
}

class _QrMainPageState extends State<QrMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("QR Code", style: TextStyle(fontSize: 36))),
            _buildFeatureButton(
              context,
              "Generate Qr Code",
              Icons.qr_code,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QrGeneratorPage()),
              ),
            ),
            SizedBox(height: 20,),
            _buildFeatureButton(
              context,
              "Scan Qr Code",
              Icons.qr_code_scanner,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanQrPage()),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 90, color: Colors.white),
            Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
