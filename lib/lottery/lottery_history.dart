import 'package:flutter/material.dart';
import 'package:lottery/lottery/ball_colors.dart';
import 'package:lottery/lottery/enums.dart';
import 'package:lottery/lottery/lottery_number.dart';
import 'package:lottery/lottery/utils.dart';

class LotteryHistoryPage extends StatefulWidget {
  const LotteryHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LotteryHistoryPageState();
  }
}

class _LotteryHistoryPageState extends State<LotteryHistoryPage> {
  late Lottery lottery;

  List<LotteryHistory> list = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      lottery = ModalRoute.of(context)?.settings.arguments as Lottery;
      Utils.historyList(lottery.type, (list) {
        setState(() {
          this.list = list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${lottery.name()}历史开奖"),
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
                    Utils.formatTime(dateTime),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Divider(height: 4),
                  LotteryNumber(
                    mainNumList: data.mainNumbers,
                    subNumList: data.bonusNumbers,
                    index: index,
                    size: 40,
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 12);
            },
            itemCount: list.length),
      ),
    );
  }
}

class LotteryHistory {
  final String drawDate;

  final List<int> mainNumbers;

  final List<int> bonusNumbers;

  LotteryHistory(this.mainNumbers, this.bonusNumbers, this.drawDate);

  LotteryHistory.fromJson(Map<String, dynamic> json)
      : drawDate = json['drawDate'],
        mainNumbers = _listDynamic2ListInt(json['mainNumbers']),
        bonusNumbers = _listDynamic2ListInt(json['bonusNumbers']);

  static List<int> _listDynamic2ListInt(List<dynamic> list) {
    return List<int>.from(list);
  }

  Map<String, dynamic> toJson() => {
        'drawDate': drawDate,
        'mainNumbers': mainNumbers,
        'bonusNumbers': bonusNumbers,
      };
}
