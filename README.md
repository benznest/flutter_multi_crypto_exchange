# Flutter Multi-Crypto Exchange

Integrate cryprocurrency exchange platforms and convert them into the same standard format.

## Exchange supported
- Bitkub.com
- Satang.pro

## Installation

Add dependencies in pubspec.yaml

```bash
dependencies:
    flutter_multi_crypto_exchange: 1.0.1
```

## Usage

Import the package to your project.

```dart
import 'package:flutter_multi_crypto_exchange/multi_crypto_exchange.dart';
```

Create instance

```dart
var mc = MultiCryptoExchange();
```

This plugin will use external plugins of each platform.
ฺBitkub     : flutter_bitkub_exchange
Satang Pro : flutter_satang_pro_exchange


Initial your API Key for fetch the balances.

```dart
  //import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
  //import 'package:flutter_satang_pro_exchange/dao/api_key/satang_pro_api_key.dart';

  // initial API key.
  mc.initSatang(
      userId: 1234,  // your user id.
      keyReading: SatangProApiKey(
          apiKey: "your key",
          secret: "your secret"));
  mc.initBitkub(
      keyReading: BitkubApiKey(
          apiKey: "your key",
          secret: "yoursecret"));
```

## Get Market

Get ticker from multi-markets, last price, percent change, volume, etc.

```dart
  // import 'package:flutter_multi_crypto_exchange/dao/multi_crypto_market_dao.dart';
  // import 'package:flutter_multi_crypto_exchange/manager/exchange_platform.dart';
  // import 'package:flutter_multi_crypto_exchange/dao/exchange_currency_market_dao.dart';

  MultiCryptoMarketDao market = await mc.getMultiMarkets();
  List<ExchangeCurrencyMarketDao> listMarketSatang = market.marketcap[ExchangePlatform.SATANG_PRO];
  List<ExchangeCurrencyMarketDao> listMarketBitkub = market.marketcap[ExchangePlatform.BITKUB];
  
  // Get information in Satang.
  for(var coin in listMarketSatang){
      // coin.percentChange;
      // coin.lastPrice;
      // coin.primaryCurrency;
      // coin.secondaryCurrency;
      // coin.avg24hr;
      // coin.baseVolume;
   }
```

## Get portfolio

Get portfolio from multi-exchanges.

```dart
  var portfolio = await mc.getPortfolio();
```

In Example, I have
0.0004 BTC , 193 THB , 116 XZC in Satang Pro.
and 0.171 BTC , 4 THB , 4.61 ETH in Bitkub.

You will receive the remaining balance of each exchange. 
And combined into a portfolio. It also separates the amount of each exchange according to currency.

```json
{
  "exchanges": {
    "satang": {
      "balance": [
        {
          "currency": "BTC",
          "order": 0.0,
          "available": 0.0004,
          "reserved": 0.0
        },
        {
          "currency": "THB",
          "order": 0.0,
          "available": 193.1086565347,
          "reserved": 0.0
        },
        {
          "currency": "XZC",
          "order": 0.0,
          "available": 116.06439389,
          "reserved": 0.0
        }
      ],
      "errorMessage": null
    },
    "bitkub": {
      "balance": [
        {
          "currency": "THB",
          "order": 0.0,
          "available": 4.49,
          "reserved": 30.0
        },
        {
          "currency": "BTC",
          "order": 0.0,
          "available": 0.17106842,
          "reserved": 0.0
        },
        {
          "currency": "ETH",
          "order": 0.0,
          "available": 4.61567764,
          "reserved": 0.01
        }
      ],
      "errorMessage": null
    }
  },
  "portfolio": [
    {
      "currency": "BTC",
      "order": 0.0,
      "available": 0.17146842,
      "reserved": 0.0,
      "balanceEachExchanges": {
        "satang": {
          "currency": "BTC",
          "order": 0.0,
          "available": 0.0004,
          "reserved": 0.0
        },
        "bitkub": {
          "currency": "BTC",
          "order": 0.0,
          "available": 0.17106842,
          "reserved": 0.0
        }
      }
    },
    {
      "currency": "THB",
      "order": 0.0,
      "available": 197.5986565347,
      "reserved": 30.0,
      "balanceEachExchanges": {
        "satang": {
          "currency": "THB",
          "order": 0.0,
          "available": 193.1086565347,
          "reserved": 0.0
        },
        "bitkub": {
          "currency": "THB",
          "order": 0.0,
          "available": 4.49,
          "reserved": 30.0
        }
      }
    },
    {
      "currency": "XZC",
      "order": 0.0,
      "available": 116.06439389,
      "reserved": 0.0,
      "balanceEachExchanges": {
        "satang": {
          "currency": "XZC",
          "order": 0.0,
          "available": 116.06439389,
          "reserved": 0.0
        }
      }
    },
    {
      "currency": "ETH",
      "order": 0.0,
      "available": 4.61567764,
      "reserved": 0.01,
      "balanceEachExchanges": {
        "bitkub": {
          "currency": "ETH",
          "order": 0.0,
          "available": 4.61567764,
          "reserved": 0.01
        }
      }
    }
  ]
}
```