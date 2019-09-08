import 'package:flutter/material.dart';
import 'package:flutter_crypto_portfolio_core/crypto_portfolio_core.dart';
import 'package:flutter_crypto_portfolio_core/dao/crypto_portfolio_dao.dart';
import 'package:flutter_crypto_portfolio_core_example/my_utils.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:flutter_satang_pro_exchange/dao/api_key/satang_pro_api_key.dart';
import 'package:flutter_crypto_portfolio_core/dao/multi_crypto_market_dao.dart';

Future main() async {
  CryptoPortfolioCore core = CryptoPortfolioCore(hideEmptyCoin: true);

  // initial API key.
  core.initSatang(
      keyReading: SatangProApiKey(
          apiKey: "live-bb7004c453c747dab95fe8b16d5c9a5e",
          secret: "b34a2Mr3RAqAkHcwnC+OTDeigz71VEFGsYTxtY+limA="));
  core.initBitkub(
      keyReading: BitkubApiKey(
          apiKey: "9b18f5aa04960aeb61ef6c73c7f31ee7",
          secret: "80dd1e3a67a2121178d429d88260af12"));

  // build portfolio.
  CryptoPortfolioDao portfolio = await core.getPortfolio();
  printPrettyJson(portfolio.toJson());

  // build multi-market.
  MultiCryptoMarketDao market = await core.getMarket();
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
