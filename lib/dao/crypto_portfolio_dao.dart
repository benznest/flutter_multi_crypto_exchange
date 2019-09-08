import 'package:flutter_crypto_portfolio_core/dao/crypto_portfolio_exchange_dao.dart';
import 'package:flutter_crypto_portfolio_core/dao/currency_balance_dao.dart';
import 'package:flutter_crypto_portfolio_core/dao/currency_balance_exchange_dao.dart';
import 'package:flutter_crypto_portfolio_core/manager/exchange_platform.dart';

import 'exchange_dao.dart';

class CryptoPortfolioDao {
  Map<String, ExchangeDao> exchanges;
  List<CurrencyBalanceExchangeDao> portfolio;

  CryptoPortfolioDao({this.exchanges, this.portfolio}) {
    if (exchanges == null) {
      exchanges = Map();
      for (String exchangeName in ExchangePlatform.exchanges) {
        exchanges[exchangeName] =
            ExchangeDao(exchangeName: exchangeName, errorMessage: "No API Key");
      }
    }

    portfolio = portfolio ?? List();
  }

  Map<String, dynamic> toJson() {
    return {
      "exchanges": this.exchanges,
      "portfolio": portfolio.map((item) => item.toJson()).toList()
    };
  }

  buildPortfolio() {
    portfolio = List();
    Map<String, List<CurrencyBalanceDao>> mapListBalanceExchanges = {
      ExchangePlatform.SATANG_NAME:
          exchanges[ExchangePlatform.SATANG_NAME].balance,
      ExchangePlatform.BITKUB_NAME:
          exchanges[ExchangePlatform.BITKUB_NAME].balance,
    };

    mapListBalanceExchanges
        .forEach((String key, List<CurrencyBalanceDao> listBalanceExchange) {
      // each exchange.
      for (CurrencyBalanceDao balance in listBalanceExchange) {
        // each coin in exchange.

        bool isExistInPortfolio = false;
        for (int i = 0; i < portfolio.length; i++) {
          // add coin to portfolio.
          if (balance.currency == portfolio[i].currency) {
            isExistInPortfolio = true;
            portfolio[i].available += balance.available;
            portfolio[i].reserved += balance.reserved;
            portfolio[i].order += balance.order;
            portfolio[i].balanceEachExchanges[key] = balance;
            break;
          }
        }

        if (!isExistInPortfolio) {
          CurrencyBalanceExchangeDao balanceExchange =
              CurrencyBalanceExchangeDao(currency: balance.currency);
          balanceExchange.available = balance.available;
          balanceExchange.order = balance.order;
          balanceExchange.reserved = balance.reserved;
          balanceExchange.balanceEachExchanges[key] = balance;
          portfolio.add(balanceExchange);
        }
      }
    });
//
//    for (List<CurrencyBalanceDao> balanceExchange in mapListBalanceExchanges) {
//
//  }
  }
}
