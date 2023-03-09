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

  LotteryConfig config();
}

class LotteryConfig {
  final BallConfig main;

  final BallConfig sub;

  LotteryConfig(this.main, this.sub);
}

class BallConfig {
  final List<int> balls;
  final int minNum;

  BallConfig.main(int maxNum, this.minNum)
      : assert(maxNum > 0 && minNum > 0),
        balls = getBalls(maxNum);

  BallConfig.sub(int maxNum, this.minNum) : balls = getBalls(maxNum);

  static List<int> getBalls(int max) {
    List<int> balls = [];
    for (int i = 0; i < max; i++) {
      balls.add(i + 1);
    }
    return balls;
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
  const SportLotto() : super(LotteryType.superLotto);

  @override
  String name() {
    return "超级大乐透";
  }

  @override
  String nextDraw() {
    return Utils.nextDraw([1, 3, 6]);
  }

  @override
  LotteryConfig config() {
    return LotteryConfig(BallConfig.main(35, 5), BallConfig.main(12, 2));
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

  @override
  LotteryConfig config() {
    return LotteryConfig(BallConfig.main(33, 6), BallConfig.main(16, 1));
  }
}
