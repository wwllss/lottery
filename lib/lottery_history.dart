import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/lottery_number.dart';
import 'package:lottery/utils.dart';

class LotteryHistoryPage extends StatefulWidget {
  final Lottery lottery;

  const LotteryHistoryPage(this.lottery, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _LotteryHistoryPageState();
  }
}

class _LotteryHistoryPageState extends State<LotteryHistoryPage> {
  List<LotteryResult> list = [];

  @override
  void initState() {
    super.initState();
    Utils.historyList(widget.lottery.type, (list) {
      setState(() {
        this.list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.lottery.name()}历史开奖"),
        centerTitle: true,
      ),
      body: Container(
        color: BallColors.bg_content,
        child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (BuildContext context, int index) {
              var data = list[index];
              var dateTime = DateTime.tryParse(data.drawDate);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index == 0 ? "最新一期   " : ""}${Utils.formatTime(dateTime)}",
                    style: TextStyle(
                      fontSize: index == 0 ? 20 : 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  LotteryNumberView(
                    lottery: widget.lottery,
                    mainNumList: data.mainNumbers,
                    subNumList: data.bonusNumbers,
                    size: index == 0 ? 40 : 35,
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemCount: list.length),
      ),
    );
  }
}

class LotteryResult {
  final String drawDate;

  final List<int> mainNumbers;

  final List<int> bonusNumbers;

  LotteryResult(this.mainNumbers, this.bonusNumbers, this.drawDate);

  LotteryResult.fromJson(Map<String, dynamic> json)
      : drawDate = json['drawDate'],
        mainNumbers = _listDynamic2ListInt(json['mainNumbers']),
        bonusNumbers = _listDynamic2ListInt(json['bonusNumbers']);

  static List<int> _listDynamic2ListInt(List<dynamic>? list) {
    return list == null ? [] : List<int>.from(list);
  }

  Map<String, dynamic> toJson() => {
        'drawDate': drawDate,
        'mainNumbers': mainNumbers,
        'bonusNumbers': bonusNumbers,
      };
}
