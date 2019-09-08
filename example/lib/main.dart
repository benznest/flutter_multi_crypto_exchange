import 'package:flutter/material.dart';
import 'package:flutter_multi_crypto_exchange/multi_crypto_exchange.dart';
import 'package:flutter_multi_crypto_exchange/dao/crypto_portfolio_dao.dart';
import 'package:flutter_multi_crypto_exchange_example/my_utils.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:flutter_satang_pro_exchange/dao/api_key/satang_pro_api_key.dart';
import 'package:flutter_multi_crypto_exchange/dao/multi_crypto_market_dao.dart';

Future main() async {
  MultiCryptoExchange mc = MultiCryptoExchange(hideEmptyCoin: true);

  // initial API key.
  mc.initSatang(
      keyReading: SatangProApiKey(
          apiKey: "live-bb7004c453c747dab95fe8b16d5c9a5e",
          secret: "b34a2Mr3RAqAkHcwnC+OTDeigz71VEFGsYTxtY+limA="));
  mc.initBitkub(
      keyReading: BitkubApiKey(
          apiKey: "9b18f5aa04960aeb61ef6c73c7f31ee7",
          secret: "80dd1e3a67a2121178d429d88260af12"));

  // build portfolio.
  CryptoPortfolioDao portfolio = await mc.getPortfolio();
  printPrettyJson(portfolio.toJson());

  // build multi-market.
  MultiCryptoMarketDao market = await mc.getMarket();
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
