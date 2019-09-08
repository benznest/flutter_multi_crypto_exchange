import 'package:flutter_multi_crypto_exchange/dao/currency_balance_dao.dart';

class ExchangeDao {
  String exchangeName;
  List<CurrencyBalanceDao> balance;
  String errorMessage;

  ExchangeDao({this.exchangeName, this.balance, this.errorMessage}) {
    balance = balance ?? List();
  }

  bool get hasError => errorMessage != null && errorMessage.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      "balance": balance?.map((item) => item.toJson())?.toList() ?? [],
      "errorMessage": this.errorMessage,
    };
  }
}
