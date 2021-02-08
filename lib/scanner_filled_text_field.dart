import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BarcodeReceiver.dart';

//
// class ScannerFilledTextField {
//   static const MethodChannel _channel =
//       const MethodChannel('scanner_filled_text_field');
//
//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

class ScannerFilledTextField extends StatefulWidget {
  final Function callback;
  final String hint;
  final BarcodeReceiver barcodeReceiver = new BarcodeReceiver();

  ScannerFilledTextField(
      {@required this.callback, @optionalTypeArgs this.hint = "Barcode"});

  @override
  State<StatefulWidget> createState() => _ScannerFilledTextFieldState();
}

class _ScannerFilledTextFieldState extends State<ScannerFilledTextField> {
  TextEditingController _controller = new TextEditingController();

  StreamSubscription barcodeSubscription;

  _ScannerFilledTextFieldState() {
    barcodeSubscription =
        widget.barcodeReceiver.barcode.listen(_barcodeReceived);
  }

  @override
  void initState() {
    super.initState();
  }

  void _barcodeReceived(String barcode) {
    debugPrint("BarcodeWidget: $barcode");
    widget.callback(barcode);
  }

  void _readBarcodeFromCamera() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        barcodeSubscription.cancel();
        return Future.value(true);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // TODO add camera support for the scanner
            /*
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: null,
              ),
              */
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: widget.hint ?? "Barcode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                controller: _controller,
              ),
            ),
            if (Platform.isIOS)
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _readBarcodeFromCamera,
              ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _barcodeReceived(_controller.text);
                _controller.clear();
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
          ],
        ),
      ),
    );
  }
}
