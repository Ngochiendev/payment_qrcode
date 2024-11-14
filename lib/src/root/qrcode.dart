import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment_qrcode/payment_qrcode.dart';

/// Generates the UPI Payment QRCode with Neon Border
class PaymentQRCode extends StatelessWidget {
  const PaymentQRCode({
    super.key,
    this.size,
    this.loader,
    this.noBarcodeWidget,
    this.embeddedImagePath,
    this.embeddedImageSize,
    this.QrErrorCorrectLevel,
    this.qrErrorStateBuilder,
    this.eyeStyle,
    this.dataModuleStyle,
    this.qrCodeLoader,
    required this.qrCodeValue,
    this.borderColor = const Color(0xFF31ABDF), // Màu mặc định cho viền neon
    this.borderRadius = 8.0,
    this.strokeWidth = 2.0,
  });

  final double? size;
  final Widget? loader;
  final Widget? noBarcodeWidget;
  final String? embeddedImagePath;
  final Size? embeddedImageSize;
  final QRErrorCorrectLevel? QrErrorCorrectLevel;
  final Widget Function(BuildContext, Object?)? qrErrorStateBuilder;
  final QrEyeStyle? eyeStyle;
  final QrDataModuleStyle? dataModuleStyle;
  final Widget? qrCodeLoader;
  final String qrCodeValue;
  final Color borderColor;
  final double borderRadius;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final FutureBuilder<ui.Image> qrFutureBuilder = FutureBuilder<ui.Image>(
      future: embeddedImagePath == null ? null : _loadOverlayImage(),
      builder: (BuildContext ctx, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasError) {
          return qrErrorStateBuilder?.call(ctx, snapshot.error) ??
              const Text("Error in loading QRCode");
        }
        if (!snapshot.hasData) {
          return qrCodeLoader ?? const CircularProgressIndicator();
        }
        return _buildNeonBorder(_qrPainter(snapshot.data));
      },
    );

    return embeddedImagePath == null
        ? _buildNeonBorder(_qrPainter(null))
        : qrFutureBuilder;
  }

  /// Hàm này bao bọc mã QR bằng hiệu ứng viền neon
  Widget _buildNeonBorder(Widget qrCodeWidget) {
    return LayoutBuilder(builder: (context, constraints) {
      final double adjustedPadding = (size.hashCode * 0.05).clamp(5.0, 15.0);
      return CustomPaint(
        painter: NeonBorderPainter(
          borderColor: borderColor,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth,
        ),
        child: Padding(
          padding: EdgeInsets.all(adjustedPadding),
          child: SizedBox(
            width: size,
            height: size,
            child: qrCodeWidget,
          ),
        ),
      );
    });
  }

  CustomPaint _qrPainter(ui.Image? image) {
    return CustomPaint(
      size: Size.square(size ?? 320),
      painter: QrPainter(
        data: qrCodeValue,
        version: QrVersions.auto,
        eyeStyle: eyeStyle ??
            const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Colors.black,
            ),
        dataModuleStyle: dataModuleStyle ??
            const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Colors.black,
            ),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: embeddedImageSize ?? const Size(40, 40),
        ),
        errorCorrectionLevel:
            QrErrorCorrectLevel?.value ?? QRErrorCorrectLevel.high.value,
        embeddedImage: image,
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ByteData byteData = await rootBundle.load(embeddedImagePath!);
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}

class NeonBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderRadius;
  final double strokeWidth;

  NeonBorderPainter({
    required this.borderColor,
    required this.borderRadius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF31ABDF), // Primary cool blue
          Color.fromARGB(255, 80, 228, 206), // Aqua Neon
          Color.fromARGB(255, 196, 78, 226), // Neon Purple
          Color.fromARGB(255, 120, 200, 250), // Sky Blue
          Color.fromARGB(255, 196, 78, 226), // Neon Purple
          Color(0xFF31ABDF), // Back to primary cool blue
        ],
        stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
