import 'package:flutter/material.dart';
import 'package:payment_qrcode/payment_qrcode.dart';

void main() {
  runApp(const MyApp());
}

/// Creates The UPI Payment QRCode
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //TODO Change UPI ID
  // final upiDetails = UPIDetails(
  //     upiID: "9167877725@axl",
  //     payeeName: "Agnel Selvan",
  //     amount: 1,
  //     transactionNote: "Hello World");
  // final upiDetailsWithoutAmount = UPIDetails(
  //   upiID: "9167877725@axl",
  //   payeeName: "Agnel Selvan",
  //   transactionNote: "Hello World",
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payment QRCode Generator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Payment QRCode without Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const PaymentQRCode(
                qrCodeValue: "214236",
                size: 220,
                embeddedImagePath: 'assets/images/logo.png',
                embeddedImageSize: Size(60, 60),
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: Colors.black,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.black,
                ),
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Payment QRCode with Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const PaymentQRCode(
                qrCodeValue:
                    "000201010212262400069704890110010114877152020153037045405220005802VN5910CTY DTSOFT6005HANOI62820321TRUONG TH LE VAN VIET052201000000000000000000010705012340818DTS0004794510423HP63047C17",
                embeddedImagePath: 'assets/images/logo.png',
                size: 280,
                QrErrorCorrectLevel: QRErrorCorrectLevel.low,
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
