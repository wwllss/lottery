import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:lottery/enums.dart';

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
      var interval = 0;
      var index = -1;
      if (weekday < pre) {
        interval = pre - weekday;
        index = pre;
      }
      if (weekday > pre && weekday < last) {
        interval = last - weekday;
        index = last;
      }
      if (i == drawList.length - 2 && weekday > last) {
        interval = drawList[0];
        index = drawList[0];
      }
      if (interval == 0 || index == -1) {
        continue;
      }
      if (interval == 1) {
        desc = "明天 ${_weekList[index]}";
      } else if (interval == 2) {
        desc = "后天 ${_weekList[index]}";
      } else {
        desc = "$interval天后 ${_weekList[index]}";
      }
      break;
    }
    return "下次开奖是 $desc";
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
    var weekday = dateTime.weekday;
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
      {int count = 1,
      bool globalNoRepeat = false,
      LotteryHistory? history,
      int? duplexMain,
      int? duplexSub}) {
    var mainConfig = config.main;
    var mainBallsSource = List<int>.from(mainConfig.balls);
    mainBallsSource.removeWhere(
        (element) => history?.mainNumbers.contains(element) ?? false);
    var mainNum = duplexMain ?? mainConfig.minNum;
    var subConfig = config.sub;
    var subBallSource = List<int>.from(subConfig.balls);
    var subNum = duplexSub ?? subConfig.minNum;
    count = globalNoRepeat ? mainBallsSource.length ~/ mainNum : count;
    List<LotteryHistory> list = [];
    for (int i = 0; i < count; i++) {
      List<int> mbs = randomBalls(
          mainBallsSource, mainNum, mainConfig.repeat, mainConfig.sort);
      if (!globalNoRepeat) {
        mainBallsSource = List<int>.from(mainConfig.balls);
        mainBallsSource.removeWhere(
            (element) => history?.mainNumbers.contains(element) ?? false);
      }
      List<int> sbs =
          randomBalls(subBallSource, subNum, subConfig.repeat, subConfig.sort);
      subBallSource = List<int>.from(subConfig.balls);
      list.add(LotteryHistory(mbs, sbs, ""));
    }
    return list;
  }

  static List<int> randomBalls(
      List<int> source, int count, bool repeat, bool sort) {
    List<int> list = [];
    if (source.length == count) {
      return List<int>.from(source);
    }
    for (int i = 0; i < count; i++) {
      var rb = _randomBall(source);
      list.add(rb);
      if (repeat) {
        continue;
      }
      source.remove(rb);
    }
    if (!sort) {
      list.sort();
    }
    return list;
  }

  static final Random _random = Random.secure();

  static int _randomBall(List<int> list) {
    return list[_random.nextInt(list.length)];
  }

  static List<List<int>> combine(int n, int k) {
    List<List<int>> ans = [];
    getCombine(ans, n, k, 1, []);
    return ans;
  }

  static void getCombine(
      List<List<int>> ans, int n, int k, int start, List<int> list) {
    if (k == 0) {
      ans.add(List<int>.from(list));
      return;
    }
    for (int i = start; i <= n - k + 1; i++) {
      list.add(i);
      getCombine(ans, n, k - 1, i + 1, list);
      list.remove(list.length - 1);
    }
  }
}
