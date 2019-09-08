#import "FlutterMultiCryptoExchangePlugin.h"
#import <flutter_multi_crypto_exchange/flutter_multi_crypto_exchange-Swift.h>

@implementation FlutterMultiCryptoExchangePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMultiCryptoExchangePlugin registerWithRegistrar:registrar];
}
@end
