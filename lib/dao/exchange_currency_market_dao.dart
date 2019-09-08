import 'package:flutter_bitkub_exchange/dao/market_ticker/bitkub_pair_currency_data_dao.dart';
import 'package:flutter_satang_pro_exchange/dao/satang_pro_market_cap_currency_dao.dart';

class ExchangeCurrencyMarketDao {
  /// currency pair.
  String primaryCurrency;
  String secondaryCurrency;

  /// information.
  double avg24hr;
  double baseVolume;
  double high24hr;
  double highestBid;
  double lastPrice;
  double low24hr;
  double lowestAsk;
  double percentChange;
  double quoteVolume;

  ExchangeCurrencyMarketDao(
      {this.primaryCurrency,
      this.secondaryCurrency,
      this.avg24hr,
      this.baseVolume,
      this.high24hr,
      this.highestBid,
      this.lastPrice,
      this.low24hr,
      this.lowestAsk,
      this.percentChange,
      this.quoteVolume});

  ExchangeCurrencyMarketDao.fromSatangMarket(
      SatangProMarketCapCurrencyDao satang) {
    primaryCurrency = satang.currencyPair.primaryCurrency;
    secondaryCurrency = satang.currencyPair.secondaryCurrency;
    avg24hr = satang.avg24hr;
    baseVolume = satang.baseVolume;
    high24hr = satang.high24hr;
    highestBid = satang.highestBid;
    lastPrice = satang.last;
    low24hr = satang.low24hr;
    lowestAsk = satang.lowestAsk;
    percentChange = satang.percentChange;
    quoteVolume = satang.quoteVolume;
  }

  ExchangeCurrencyMarketDao.fromBitkub(BitkubPairCurrencyDataDao bitkub) {
    List<String> pair = bitkub.pairName.split("_");
    primaryCurrency = pair[1];
    secondaryCurrency = pair[0];
    avg24hr = (bitkub.high24hr + bitkub.low24hr) / 2;
    baseVolume = bitkub.baseVolume;
    high24hr = bitkub.high24hr;
    highestBid = bitkub.highestBid;
    lastPrice = bitkub.last;
    low24hr = bitkub.low24hr;
    lowestAsk = bitkub.lowestAsk;
    percentChange = bitkub.percentChange;
    quoteVolume = bitkub.quoteVolume;
  }

  Map<String, dynamic> toJson() {
    return {
      "primaryCurrency": this.primaryCurrency,
      "secondaryCurrency": this.secondaryCurrency,
      "avg24hr": this.avg24hr,
      "baseVolume": this.baseVolume,
      "high24hr": this.high24hr,
      "highestBid": this.highestBid,
      "lastPrice": this.lastPrice,
      "low24hr": this.low24hr,
      "lowestAsk": this.lowestAsk,
      "percentChange": this.percentChange,
      "quoteVolume": this.quoteVolume,
    };
  }
}
