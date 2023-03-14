import 'dart:ui';

import 'package:lottery/ball_colors.dart';
import 'package:lottery/utils.dart';

enum LotteryType { doubleColourBall, superLotto, happy8 }

abstract class Lottery {
  static final List<Lottery> sportList = [const SportLotto()];

  static final List<Lottery> welfareList = [
    const DoubleColourBall(),
    const Happy8()
  ];

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
  final Color color;
  final bool repeat;
  final bool sort;

  BallConfig.main(int maxNum, this.minNum, this.color, this.repeat, this.sort)
      : balls = getBalls(maxNum);

  BallConfig.sub(int maxNum, this.minNum, this.color, this.repeat, this.sort)
      : balls = getBalls(maxNum);

  static List<int> getBalls(int max) {
    List<int> balls = [];
    for (int i = 0; i < max; i++) {
      balls.add(i + 1);
    }
    return List.unmodifiable(balls);
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
    return LotteryConfig(BallConfig.main(35, 5, BallColors.bb, false, false),
        BallConfig.main(12, 2, BallColors.by, false, false));
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
    return LotteryConfig(BallConfig.main(33, 6, BallColors.br, false, false),
        BallConfig.main(16, 1, BallColors.bb, false, false));
  }
}

class Happy8 extends WelfareLottery {
  const Happy8() : super(LotteryType.happy8);

  @override
  String name() {
    return "快乐8";
  }

  @override
  String nextDraw() {
    return Utils.nextDraw([1, 2, 3, 4, 5, 6, 7]);
  }

  @override
  LotteryConfig config() {
    return LotteryConfig(BallConfig.main(80, 10, BallColors.br, false, false),
        BallConfig.main(0, 0, BallColors.bb, false, false));
  }
}
