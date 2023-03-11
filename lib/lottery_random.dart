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
  List<dynamic> selectedList = [];
  bool _includeNewest = false;
  int _count = 1;

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
                    var history = selectedList[index];
                    if (history is LotteryHistory) {
                      return LotteryNumberView(
                        lottery: widget.lottery,
                        mainNumList: history.mainNumbers,
                        subNumList: history.bonusNumbers,
                        size: 35,
                      );
                    }
                    if (history is String) {
                      return Row(
                        children: [
                          Text(
                            history,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text("未知数据类型");
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    var ni = index + 1;
                    if (ni >= 0 &&
                        ni < selectedList.length &&
                        selectedList[ni] is String) {
                      return const SizedBox(height: 24);
                    }
                    return const SizedBox(height: 8);
                  },
                  itemCount: selectedList.length),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () {
                setState(() {
                  _includeNewest = !_includeNewest;
                });
              },
              child: Row(
                children: [
                  Checkbox(
                    value: _includeNewest,
                    onChanged: (value) {
                      setState(() {
                        _includeNewest = !_includeNewest;
                      });
                    },
                  ),
                  const Text(
                    "包含上期开奖号码",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _newSelectedList(
                            Utils.random(
                              widget.lottery.config(),
                              globalNoRepeat: true,
                              history: _includeNewest ? null : newestHistory,
                            ),
                            "互斥随机");
                      });
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
                      setState(() {
                        _newSelectedList(
                            Utils.random(
                              widget.lottery.config(),
                              count: 1,
                              history: _includeNewest ? null : newestHistory,
                            ),
                            "随机1注");
                      });
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
                      setState(() {
                        _newSelectedList(
                            Utils.random(
                              widget.lottery.config(),
                              count: 5,
                              history: _includeNewest ? null : newestHistory,
                            ),
                            "随机5注");
                      });
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

  void _newSelectedList(List<LotteryHistory> list, String desc) {
    selectedList.insertAll(0, list);
    selectedList.insert(
        0, "第${_count++}次，$desc，${_includeNewest ? "" : "不"}包含上期开奖号码");
  }
}
