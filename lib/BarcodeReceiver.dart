import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class BarcodeReceiver {
  final EventChannel eventChannel = new EventChannel("com.eloware.messcanner.barcodeReceived");

  String strTrimHard(String value) => value.trim().replaceAll("\r", "").replaceAll("\n", "");

  StreamSubscription<dynamic> subscription;
  StreamController<String> _barcodes = new StreamController<String>.broadcast();

  Stream<String> get barcode {
    return _barcodes.stream;
  }

  BarcodeReceiver() {
    if (Platform.isAndroid)
      subscription = eventChannel.receiveBroadcastStream().listen(_barcodeReceived);
  }

  void dismiss() {
    subscription.cancel();
  }

  void _barcodeReceived(dynamic data) {
    String code = checkSumTest(data as String);
    _barcodes.add(strTrimHard(code));
  }

  static String checkSumTest(String code) {
    List<String> chars = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
      "-",
      ".",
      " ",
      "\$",
      "/",
      "+",
      "%"
    ];

    int sum = 0;
    for (int i = 0; i < code.length - 1; i++) sum += chars.indexOf(code[i]);

    String checkChar = code[code.length - 1];
    if (chars.indexOf(checkChar) % 43 == sum) return code.substring(0, code.length - 1);

    return code;
  }
}
