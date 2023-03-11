import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:lottery/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lottery_history.dart';

class Utils {
  Utils._();

  static final List<String> _weekList = [
    "",
    "星期一",
    "星期二",
    "星期三",
    "星期四",
    "星期五",
    "星期六",
    "星期天"
  ];

  static String nextDraw(List<int> drawList) {
    var now = DateTime.now();
    var weekday = now.weekday;
    var desc = "";
    for (int i = 0; i < drawList.length - 1; i++) {
      var pre = drawList[i];
      var last = drawList[i + 1];
      if (weekday == pre || weekday == last) {
        desc = "今天 ${_weekList[weekday]}";
        break;
      }
      if (weekday > pre && weekday < last) {
        var interval = last - weekday;
        if (interval == 1) {
          desc = "明天 ${_weekList[last]}";
        } else if (interval == 2) {
          desc = "后天 ${_weekList[last]}";
        } else {
          desc = "$interval天后 ${_weekList[last]}";
        }
      }
    }
    return "下次开奖是 $desc";
  }

  static Future<String> newestHistory() async {
    var instance = await SharedPreferences.getInstance();
    return "";
  }

  static Future<String> historyStr(LotteryType type) async {
    return await rootBundle.loadString("assets/history/${type.name}.json");
  }

  static void historyList(
      LotteryType type, void Function(List<LotteryHistory> list) onList) {
    historyStr(type).then((value) {
      Iterable i = jsonDecode(value);
      var list =
          List<LotteryHistory>.from(i.map((e) => LotteryHistory.fromJson(e)));
      onList(list);
    });
  }

  static String weekdayDesc(DateTime dateTime) {
    return weekdayDescWithInt(dateTime.weekday);
  }

  static String weekdayDescWithInt(int weekday) {
    if (weekday < 1 || weekday >= _weekList.length) {
      return "未知";
    }
    return _weekList[weekday];
  }

  static String formatTime(DateTime? dateTime) {
    return dateTime == null
        ? "未知日期"
        : "${dateTime.year}年${dateTime.month}月${dateTime.day}日 ${weekdayDesc(dateTime)}";
  }

  static List<LotteryHistory> random(LotteryConfig config,
      {int count = 1, bool globalNoRepeat = false, LotteryHistory? history}) {
    var mainConfig = config.main;
    var mainBallsSource = List<int>.from(mainConfig.balls);
    mainBallsSource.removeWhere(
        (element) => history?.mainNumbers.contains(element) ?? false);
    var mainNum = mainConfig.minNum;
    var subConfig = config.sub;
    var subBallSource = List<int>.from(subConfig.balls);
    var subNum = subConfig.minNum;
    count = globalNoRepeat ? mainBallsSource.length ~/ mainNum : count;
    List<LotteryHistory> list = [];
    for (int i = 0; i < count; i++) {
      List<int> mbs = [];
      for (int m = 0; m < mainNum; m++) {
        var rb = _randomBall(mainBallsSource);
        mbs.add(rb);
        if (mainConfig.repeat) {
          continue;
        }
        mainBallsSource.remove(rb);
      }
      mbs.sort();
      if (!globalNoRepeat) {
        mainBallsSource = List<int>.from(mainConfig.balls);
        mainBallsSource.removeWhere(
            (element) => history?.mainNumbers.contains(element) ?? false);
      }
      List<int> sbs = [];
      for (int s = 0; s < subNum; s++) {
        var rb = _randomBall(subBallSource);
        sbs.add(rb);
        if (subConfig.repeat) {
          continue;
        }
        subBallSource.remove(rb);
      }
      sbs.sort();
      subBallSource = List<int>.from(subConfig.balls);
      list.add(LotteryHistory(mbs, sbs, ""));
    }
    return list;
  }

  static final Random _random = Random();

  static int _randomBall(List<int> list) {
    return list[_random.nextInt(list.length)];
  }
}
