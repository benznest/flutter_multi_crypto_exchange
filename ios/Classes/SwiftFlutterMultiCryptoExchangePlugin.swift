import Flutter
import UIKit

public class SwiftFlutterMultiCryptoExchangePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_multi_crypto_exchange", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMultiCryptoExchangePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
