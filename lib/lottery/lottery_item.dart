import 'package:flutter/material.dart';
import 'package:lottery/lottery/ball_colors.dart';

import 'enums.dart';
import 'lottery_number.dart';

class LotteryItem extends StatelessWidget {
  final Lottery lottery;

  const LotteryItem(this.lottery, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            lottery.group(),
            style: const TextStyle(color: BallColors.black_999),
          ),
          const SizedBox(height: 4),
          Text(
            lottery.nextDraw(),
            style: const TextStyle(color: BallColors.black_999),
          ),
          const SizedBox(height: 6),
          const LotteryNumber(mainNumList: [1, 2, 3, 4, 5, 6], subNumList: [7],size: 30,),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  //TODO 去选号
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: BallColors.bg_btn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "选号",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
              const SizedBox(width: 12),
              Expanded(
                  child: InkWell(
                onTap: () {
                  //TODO 去开奖历史
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: BallColors.bg_btn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "开奖历史",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
