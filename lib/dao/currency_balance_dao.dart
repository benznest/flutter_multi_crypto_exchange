import 'package:flutter/material.dart';

class CurrencyBalanceDao {
  String currency;
  double order;
  double available;
  double reserved;

  CurrencyBalanceDao(
      {@required this.currency,
      this.order = 0,
      this.available = 0,
      this.reserved = 0});

  Map<String, dynamic> toJson() {
    return {
      "currency": this.currency,
      "order": this.order,
      "available": this.available,
      "reserved": this.reserved,
    };
  }

  double get total {
    return order + available + reserved;
  }
}
