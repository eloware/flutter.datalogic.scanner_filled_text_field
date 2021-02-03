import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_filled_text_field/scanner_filled_text_field.dart';

void main() {
  const MethodChannel channel = MethodChannel('scanner_filled_text_field');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ScannerFilledTextField.platformVersion, '42');
  });
}
