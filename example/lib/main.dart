import 'package:flutter/material.dart';
import 'package:flutter_multi_crypto_exchange/multi_crypto_exchange.dart';
import 'package:flutter_multi_crypto_exchange/dao/crypto_portfolio_dao.dart';
import 'package:flutter_multi_crypto_exchange_example/my_utils.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:flutter_satang_pro_exchange/dao/api_key/satang_pro_api_key.dart';

import 'package:flutter_multi_crypto_exchange/dao/multi_crypto_market_dao.dart';
import 'package:flutter_multi_crypto_exchange/manager/exchange_platform.dart';
import 'package:flutter_multi_crypto_exchange/dao/exchange_currency_market_dao.dart';

Future main() async {
  MultiCryptoExchange mc = MultiCryptoExchange();

  // initial API key.
  mc.initSatang(
      userId: 1234,  // your user id.
      keyReading: SatangProApiKey(
          apiKey: "...",
          secret: "..."));
  mc.initBitkub(
      keyReading: BitkubApiKey(
          apiKey: "...",
          secret: "..."));

  // build portfolio.
  CryptoPortfolioDao portfolio = await mc.getPortfolio();
  printPrettyJson(portfolio.toJson());

  // build multi-market.
  MultiCryptoMarketDao market = await mc.getMultiMarkets();
  List<ExchangeCurrencyMarketDao> listMarketSatang = market.marketcap[ExchangePlatform.SATANG_PRO];
  List<ExchangeCurrencyMarketDao> listMarketBitkub = market.marketcap[ExchangePlatform.BITKUB];
  for(var coin in listMarketSatang){
    // coin.percentChange;
    // coin.lastPrice;
    // coin.primaryCurrency;
    // coin.secondaryCurrency;
    // coin.avg24hr;
    // coin.baseVolume;
  }
  printPrettyJson(market.toJson());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'CRYPTO PORTFOLIO CORE',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
