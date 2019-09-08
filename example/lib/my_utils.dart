import 'dart:convert';

import 'package:flutter/material.dart';

printPrettyJson(Map json){
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  debugPrint(prettyprint);
}