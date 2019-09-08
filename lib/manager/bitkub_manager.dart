import 'package:flutter_bitkub_exchange/bitkub_exchange.dart';
import 'package:flutter_bitkub_exchange/bitkub_utils.dart';
import 'package:flutter_bitkub_exchange/dao/balance/bitkub_currency_balance_dao.dart';
import 'package:flutter_bitkub_exchange/dao/balance/bitkub_wallet_balance_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_ticker/bitkub_market_ticker_dao.dart';
import 'package:flutter_bitkub_exchange/dao/market_ticker/bitkub_pair_currency_data_dao.dart';
import 'package:flutter_crypto_portfolio_core/dao/exchange_currency_market_dao.dart';
import 'package:flutter_crypto_portfolio_core/dao/exchange_dao.dart';
import 'package:flutter_crypto_portfolio_core/dao/currency_balance_dao.dart';
import 'package:flutter_crypto_portfolio_core/manager/exchange_platform.dart';

class BitkubManager {
  static List<CurrencyBalanceDao> toCurrencyBalance(
      List<BitkubCurrencyBalanceDao> listBalanceBitkub,
      {bool hideEmptyCoin = true}) {
    List<CurrencyBalanceDao> listBalance = List();
    for (BitkubCurrencyBalanceDao balanceBitkub in listBalanceBitkub) {
      if (balanceBitkub.balance == 0 && hideEmptyCoin) {
        // not add to list.
      } else {
        listBalance.add(CurrencyBalanceDao(
            currency: balanceBitkub.currency.toUpperCase(),
            available: balanceBitkub.detail.available,
            reserved: balanceBitkub.detail.reserved));
      }
    }
    return listBalance;
  }

  static Future<ExchangeDao> buildPortfolioExchange(
      BitkubExchangeService service,
      {bool hideEmptyCoin = true}) async {
    BitkubWalletBalanceDao response = await service.fetchWalletBalance();
    ExchangeDao exchange =
        ExchangeDao(exchangeName: ExchangePlatform.BITKUB_NAME);
    if (response.isError()) {
      exchange.errorMessage = response.errorMessage;
    } else {
      List<CurrencyBalanceDao> list = BitkubManager.toCurrencyBalance(
          response.wallets,
          hideEmptyCoin: hideEmptyCoin);
      exchange.balance = list;
    }
    return exchange;
  }

  static Future<List<ExchangeCurrencyMarketDao>> buildMarket(
      BitkubExchangeService service) async {
    List<ExchangeCurrencyMarketDao> listMarketCap = List();
    BitkubMarketTickerDao response = await service.fetchMarketTicker();
    for(BitkubPairCurrencyDataDao marketBitkub in response.list){
      listMarketCap.add(ExchangeCurrencyMarketDao.());
    }
    return listMarketCap;
  }
}
