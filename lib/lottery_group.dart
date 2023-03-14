import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';

import 'enums.dart';
import 'lottery_item.dart';

class LotteryGroupView extends StatelessWidget {
  final List<Lottery> lotteryList;

  const LotteryGroupView(this.lotteryList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BallColors.bg_content,
      child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return LotteryItemView(lotteryList[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemCount: lotteryList.length),
    );
  }
}
