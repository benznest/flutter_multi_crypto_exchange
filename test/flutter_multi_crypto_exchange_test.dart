import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_multi_crypto_exchange/flutter_multi_crypto_exchange.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_multi_crypto_exchange');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterMultiCryptoExchange.platformVersion, '42');
  });
}
