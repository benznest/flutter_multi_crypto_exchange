import 'package:flutter_bitkub_exchange/bitkub_exchange.dart';
import 'package:flutter_bitkub_exchange/dao/api_key/bitkub_api_key.dart';
import 'package:flutter_multi_crypto_exchange/manager/exchange_platform.dart';
import 'package:flutter_multi_crypto_exchange/dao/exchange_currency_market_dao.dart';
import 'package:flutter_multi_crypto_exchange/dao/multi_crypto_market_dao.dart';
import 'package:flutter_multi_crypto_exchange/manager/bitkub_manager.dart';
import 'package:flutter_multi_crypto_exchange/dao/crypto_portfolio_dao.dart';
import 'package:flutter_multi_crypto_exchange/manager/satang_manager.dart';
import 'package:flutter_satang_pro_exchange/dao/api_key/satang_pro_api_key.dart';
import 'package:flutter_satang_pro_exchange/satang_pro_exchange.dart';

class MultiCryptoExchange {
  bool hideEmptyCoin = true;
  SatangProExchangeService satangService;
  BitkubExchangeService bitkubService;

  MultiCryptoExchange(
      {this.hideEmptyCoin = true, this.satangService, this.bitkubService}) {
    satangService = satangService ?? SatangProExchangeService();
    bitkubService = bitkubService ?? BitkubExchangeService();
  }

  initSatang(
      {int userId, SatangProApiKey keyReading, SatangProApiKey keyOrdering}) {
    satangService = SatangProExchangeService(
        userId: userId, apiKeyUserInfo: keyReading, apiKeyOrder: keyOrdering);
  }

  initBitkub(
      {BitkubApiKey keyReading,
      BitkubApiKey keyCreateOrder,
      BitkubApiKey keyCancelOrder}) {
    bitkubService = BitkubExchangeService(
        apiKeyGeneral: keyReading,
        apiKeyCreateOrder: keyCreateOrder,
        apiKeyCancelOrder: keyCancelOrder);
  }

  Future<CryptoPortfolioDao> getPortfolio() async {
    CryptoPortfolioDao portfolio = CryptoPortfolioDao();

    // Fetch balance Satang.
    if (satangService != null && satangService.apiKeyUserInfo != null) {
      portfolio.exchanges[ExchangePlatform.SATANG_NAME] =
          await SatangManager.buildPortfolioExchange(satangService,
              hideEmptyCoin: hideEmptyCoin);
    }

    // Fetch balance Bitkub.
    if (bitkubService != null && bitkubService.apiKeyGeneral != null) {
      portfolio.exchanges[ExchangePlatform.BITKUB_NAME] =
          await BitkubManager.buildPortfolioExchange(bitkubService,
              hideEmptyCoin: hideEmptyCoin);
    }

    // build portfolio by exchange balance data.
    portfolio.buildPortfolio();

    return portfolio;
  }

  Future<MultiCryptoMarketDao> getMarket() async {
    MultiCryptoMarketDao multiMarket = MultiCryptoMarketDao();

    /// Fetch balance Satang.
    if (satangService != null) {
      multiMarket.marketcap[ExchangePlatform.SATANG_NAME] =
          await SatangManager.buildMarket(satangService);
    }

    /// Fetch balance Bitkub.
    if (bitkubService != null) {
      multiMarket.marketcap[ExchangePlatform.BITKUB_NAME] =
          await BitkubManager.buildMarket(bitkubService);
    }

    return multiMarket;
  }
}
