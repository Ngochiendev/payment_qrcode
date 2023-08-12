enum QRErrorCorrectLevel {
  low,
  medium,
  quality,
  high;

  int get value {
    switch (this) {
      case QRErrorCorrectLevel.high:
        return 2;
      case QRErrorCorrectLevel.low:
        return 1;
      case QRErrorCorrectLevel.medium:
        return 0;
      case QRErrorCorrectLevel.quality:
        return 3;
      default:
        return 0;
    }
  }
}
