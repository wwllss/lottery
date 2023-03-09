import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';

import 'enums.dart';
import 'lottery_item.dart';

class LotteryGroupView extends StatelessWidget {
  final List<Lottery> lotteryList;

  const LotteryGroupView(this.lotteryList,{super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BallColors.bg_content,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: lotteryList.map((e) => LotteryItemView( e)).toList(),
        ),
      ),
    );
  }
}
