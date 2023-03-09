import 'package:flutter/material.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/lottery_history.dart';
import 'package:lottery/lottery_random.dart';

class Routes {
  Routes._();

  static Route<dynamic>? make(RouteSettings settings) {
    var name = settings.name ?? "";
    if ("/history" == name) {
      return MaterialPageRoute(
          builder: (context) =>
              LotteryHistoryPage(settings.arguments as Lottery));
    }
    if ("/random" == name) {
      return MaterialPageRoute(
          builder: (context) =>
              LotteryRandomPage(settings.arguments as Lottery));
    }
    return null;
  }
}
