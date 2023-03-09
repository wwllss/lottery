import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/enums.dart';

class LotteryRandomPage extends StatefulWidget {
  final Lottery lottery;

  const LotteryRandomPage(this.lottery, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _LotteryRandomPageState();
  }
}

class _LotteryRandomPageState extends State<LotteryRandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lottery.name()),
        centerTitle: true,
      ),
      body: Container(
        color: BallColors.bg_content,
      ),
    );
  }
}
