import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const QRHomePage(),
    );
  }
}

class QRHomePage extends StatefulWidget {
  const QRHomePage({super.key});

  @override
  State<QRHomePage> createState() => _QRHomePageState();
}

class _QRHomePageState extends State<QRHomePage> {
  final TextEditingController controller = TextEditingController();

  String qrData = "https://github.com/";

  String scannedResult = "No QR scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Generator & Scanner"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // TextField
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter text or GitHub link",
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  qrData = controller.text;
                });
              },
              child: const Text("Generate QR"),
            ),

            const SizedBox(height: 20),

            // QR Code
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 220,
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 20),

            const Text(
              "QR Scanner",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 300,

              child: MobileScanner(
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;

                  for (final barcode in barcodes) {
                    setState(() {
                      scannedResult =
                          barcode.rawValue ?? "No data found";
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              scannedResult,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
