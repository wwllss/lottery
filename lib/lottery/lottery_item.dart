import 'package:flutter/material.dart';
import 'package:lottery/lottery/ball_colors.dart';

import 'enums.dart';

class LotteryItem extends StatelessWidget {
  final Lottery lottery;

  const LotteryItem({super.key, required this.lottery});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lottery.name(),
            style: const TextStyle(
                color: BallColors.black_333,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            lottery.group(),
            style: const TextStyle(color: BallColors.black_999),
          ),
          const SizedBox(height: 6),
          Text(
            lottery.nextDraw(),
            style: const TextStyle(color: BallColors.black_999),
          ),
        ],
      ),
    );
  }
}
