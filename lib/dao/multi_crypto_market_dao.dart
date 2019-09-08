import 'package:flutter_multi_crypto_exchange/dao/exchange_currency_market_dao.dart';
import 'package:flutter_satang_pro_exchange/dao/satang_pro_market_cap_currency_dao.dart';

class MultiCryptoMarketDao{
  Map<String, List<ExchangeCurrencyMarketDao>> marketcap;

  MultiCryptoMarketDao({this.marketcap}){
    marketcap = marketcap ?? Map();
  }

  Map<String, dynamic> toJson() {
    return {"marketcap": this.marketcap,};
  }


}