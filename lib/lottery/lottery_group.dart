import 'package:flutter/material.dart';
import 'package:lottery/lottery/ball_colors.dart';

import 'enums.dart';
import 'lottery_item.dart';

class LotteryGroup extends StatelessWidget {
  final List<Lottery> lotteryList;

  const LotteryGroup({super.key, required this.lotteryList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BallColors.bg_content,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: lotteryList.map((e) => LotteryItem(lottery: e)).toList(),
        ),
      ),
    );
  }
}
