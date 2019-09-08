import 'package:flutter_multi_crypto_exchange/dao/exchange_dao.dart';
import 'package:flutter_multi_crypto_exchange/dao/currency_balance_dao.dart';
import 'package:flutter_multi_crypto_exchange/dao/exchange_currency_market_dao.dart';
import 'package:flutter_multi_crypto_exchange/manager/exchange_platform.dart';
import 'package:flutter_satang_pro_exchange/dao/satang_pro_market_cap_currency_dao.dart';
import 'package:flutter_satang_pro_exchange/dao/user_information/satang_pro_user_information_dao.dart';
import 'package:flutter_satang_pro_exchange/dao/wallets/satang_pto_wallet_dao.dart';
import 'package:flutter_satang_pro_exchange/satang_pro_exchange.dart';
import 'package:flutter_satang_pro_exchange/satang_pro_utils.dart';

class SatangManager {
  static const String EXCHANGE_NAME = ExchangePlatform.SATANG_NAME;

  static List<CurrencyBalanceDao> toCurrencyBalance(
      List<SatangProWalletDao> listBalanceSatang,
      {bool hideEmptyCoin = true}) {
    List<CurrencyBalanceDao> listBalance = List();
    if (listBalanceSatang != null) {
      for (SatangProWalletDao balanceSatang in listBalanceSatang) {
        if (balanceSatang.availableBalance == 0 && hideEmptyCoin) {
          // not add list.
        } else {
          listBalance.add(CurrencyBalanceDao(
              currency: balanceSatang.currency.toUpperCase(),
              available: balanceSatang.availableBalance));
        }
      }
    }
    return listBalance;
  }

  static Future<ExchangeDao> buildPortfolioExchange(
      SatangProExchangeService service,
      {bool hideEmptyCoin = true}) async {
    SatangProUserInformationDao response =
        await service?.fetchUserInformation();
    ExchangeDao exchange = ExchangeDao(exchangeName: EXCHANGE_NAME);

    if (response.isError) {
      exchange.errorMessage = response.error.message;
    } else if (response.id == null) {
      exchange.errorMessage = "API Key invalid.";
    } else {
      List<CurrencyBalanceDao> list = SatangManager.toCurrencyBalance(
          response?.wallets?.list,
          hideEmptyCoin: hideEmptyCoin);
      exchange.balance = list;
    }
    return exchange;
  }

  static Future<List<ExchangeCurrencyMarketDao>> buildMarket(
      SatangProExchangeService service) async {
    List<ExchangeCurrencyMarketDao> listCentralMarketCap = List();
    List<SatangProMarketCapCurrencyDao> listSatangMarketCap =
        await service.fetchMarket();

    for (SatangProMarketCapCurrencyDao satangMarket in listSatangMarketCap) {
      listCentralMarketCap
          .add((ExchangeCurrencyMarketDao.fromSatangMarket(satangMarket)));
    }

    return listCentralMarketCap;
  }
}
