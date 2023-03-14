import 'package:flutter/material.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/utils.dart';

class LotteryNumberView extends StatelessWidget {
  final Lottery lottery;

  final List<int> mainNumList;

  final List<int> subNumList;

  final double size;

  const LotteryNumberView(
      {super.key,
      required this.lottery,
      required this.mainNumList,
      List<int>? subNumList,
      double? size})
      : size = size ?? 40,
        subNumList = subNumList ?? const [];

  @override
  Widget build(BuildContext context) {
    if (mainNumList.isEmpty) {
      return SizedBox.fromSize(size: Size.zero);
    }
    List<Widget> list = _addBalls(mainNumList, lottery.config().main.color);
    if (subNumList.isNotEmpty) {
      list.add(Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Icon(
          Icons.add,
          color: lottery.config().main.color,
          size: 18,
        ),
      ));
      list.addAll(_addBalls(subNumList, lottery.config().sub.color));
    }
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: list,
    );
  }

  List<Widget> _addBalls(List<int> ballList, Color color) {
    List<Widget> list = [];
    for (var element in ballList) {
      list.add(Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(size)),
        child: Text(
          Utils.formatBall(element),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ));
    }
    return list;
  }
}
