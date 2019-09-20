import 'package:flutter/material.dart';
import 'package:flutter_multi_crypto_exchange/dao/currency_balance_dao.dart';

class CurrencyBalanceExchangeDao {
  String currency;
  double order;
  double available;
  double reserved;

  Map<String, CurrencyBalanceDao> balanceEachExchanges;

  CurrencyBalanceExchangeDao({@required this.currency,
    this.order = 0,
    this.available = 0,
    this.reserved = 0,
    this.balanceEachExchanges}) {
    balanceEachExchanges = balanceEachExchanges ?? Map();
  }

  Map<String, dynamic> toJson() {
    return {
      "currency": this.currency,
      "order": this.order,
      "available": this.available,
      "reserved": this.reserved,
      "balanceEachExchanges":this.balanceEachExchanges
    };
  }


  double get total {
    return order + available + reserved;
  }
}
