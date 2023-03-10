import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/utils.dart';

import 'lottery_history.dart';
import 'lottery_number.dart';

class LotteryRandomPage extends StatefulWidget {
  final Lottery lottery;

  const LotteryRandomPage(this.lottery, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _LotteryRandomPageState();
  }
}

class _LotteryRandomPageState extends State<LotteryRandomPage> {
  LotteryHistory? newestHistory;
  List<LotteryHistory> selectedList = [];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lottery.name()),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: BallColors.bg_content,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "上期开奖号码：",
                  style: TextStyle(color: Colors.white),
                ),
                newestHistory == null
                    ? const SizedBox()
                    : LotteryNumberView(
                        lottery: widget.lottery,
                        mainNumList: newestHistory?.mainNumbers ?? [],
                        subNumList: newestHistory?.bonusNumbers ?? [],
                        size: 25,
                      ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return const Text("test");
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 6);
                  },
                  itemCount: 100),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //TODO 互斥随机
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: BallColors.bb,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "互斥随机",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //TODO 互斥随机
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: BallColors.bb,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "随机1注",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //TODO 互斥随机
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: BallColors.bb,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "随机5注",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
