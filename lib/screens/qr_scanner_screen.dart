import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(
        title: Text("امسح الكود للتسوق", style: TextStyle(color: gold)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: gold),
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            // هنا يتم توجيه المستخدم للمنتج الممسوح
          }
        },
      ),
    );
  }
}
