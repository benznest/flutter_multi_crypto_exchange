import 'dart:async';

import 'package:flutter/services.dart';

class FlutterMultiCryptoExchange {
  static const MethodChannel _channel =
      const MethodChannel('flutter_multi_crypto_exchange');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
