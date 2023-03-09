import 'package:lottery/utils.dart';

enum LotteryType { doubleColourBall, superLotto }

abstract class Lottery {
  static final List<Lottery> sportList = [const SportLotto()];

  static final List<Lottery> welfareList = [const DoubleColourBall()];

  final LotteryType type;

  const Lottery(this.type);

  String name();

  String group();

  String nextDraw();
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
  const SportLotto() : super(LotteryType.superLotto);

  @override
  String name() {
    return "超级大乐透";
  }

  @override
  String nextDraw() {
    return Utils.nextDraw([1, 3, 6]);
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
    return Utils.nextDraw([2, 4, 7]);
  }
}
