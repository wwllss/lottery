import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/lottery_history.dart';
import 'package:lottery/utils.dart';

import 'enums.dart';
import 'lottery_number.dart';

class LotteryItemView extends StatefulWidget {
  final Lottery lottery;

  const LotteryItemView(this.lottery, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _LotteryItemViewState();
  }
}

class _LotteryItemViewState extends State<LotteryItemView> {
  LotteryResult? newestHistory;

  @override
  void initState() {
    Utils.historyList(widget.lottery.type, (list) {
      if (list.isNotEmpty) {
        setState(() {
          newestHistory = list[0];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> historyWidget = newestHistory == null
        ? [const SizedBox()]
        : [
            const SizedBox(height: 8),
            LotteryNumberView(
              lottery: widget.lottery,
              mainNumList: newestHistory?.mainNumbers ?? [],
              subNumList: newestHistory?.bonusNumbers ?? [],
              size: 28,
            )
          ];
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
            widget.lottery.name(),
            style: const TextStyle(
              color: BallColors.black_333,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.lottery.group(),
            style: const TextStyle(color: BallColors.black_999),
          ),
          const SizedBox(height: 4),
          Text(
            widget.lottery.nextDraw(),
            style: const TextStyle(color: BallColors.black_999),
          ),
          ...historyWidget,
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/random",
                      arguments: widget.lottery);
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: BallColors.bg_btn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "随机选号",
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
                  Navigator.pushNamed(context, "/history",
                      arguments: widget.lottery);
                },
                child: Container(
                  height: 35,
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
