enum LotteryType { doubleColourBall, sportsLotto }

abstract class Lottery {
  static final List<Lottery> sportList = [const SportLotto()];

  static final List<Lottery> welfareList = [const DoubleColourBall()];

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

  final LotteryType type;

  const Lottery(this.type);

  String name();

  String group();

  String nextDraw();

  String _nextDraw(List<int> drawList) {
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
}

///////中国体育彩票

abstract class SportLottery extends Lottery {
  const SportLottery(super.type);

  @override
  String group() {
    return "中国体育彩票";
  }
}

class SportLotto extends SportLottery {
  const SportLotto() : super(LotteryType.sportsLotto);

  @override
  String name() {
    return "超级大乐透";
  }

  @override
  String nextDraw() {
    return _nextDraw([1, 3, 6]);
  }
}

///////中国福利彩票

abstract class WelfareLottery extends Lottery {
  const WelfareLottery(super.type);

  @override
  String group() {
    return "中国福利彩票";
  }
}

class DoubleColourBall extends WelfareLottery {
  const DoubleColourBall() : super(LotteryType.doubleColourBall);

  @override
  name() {
    return "双色球";
  }

  @override
  String nextDraw() {
    return _nextDraw([2, 4, 7]);
  }
}
