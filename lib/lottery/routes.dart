import 'package:flutter/material.dart';
import 'package:lottery/lottery/lottery_history.dart';

class Routes {
  Routes._();

  static Route<dynamic>? make(RouteSettings settings) {
    var name = settings.name ?? "";
    if ("/history" == name) {
      return MaterialPageRoute(
          builder: (context) => const LotteryHistoryPage(), settings: settings);
    }
    return null;
  }
}
