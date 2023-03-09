import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';

class LotteryNumber extends StatelessWidget {

  final List<int> mainNumList;

  final List<int> subNumList;

  final Color ballColor;

  final double size;

  const LotteryNumber(
      {super.key,
      required this.mainNumList,
      List<int>? subNumList,
      double? size,
      Color? color,
      int? index})
      : assert(color == null || index == null,
            'Cannot provide both a color and a index'),
        size = size ?? 40,
        ballColor = color ??
            (index == null
                ? BallColors.b_3
                : index % 4 == 0
                    ? BallColors.b_1
                    : index % 4 == 1
                        ? BallColors.b_2
                        : index % 4 == 3
                            ? BallColors.b_4
                            : BallColors.b_3),
        subNumList = subNumList ?? const [];

  @override
  Widget build(BuildContext context) {
    if (mainNumList.isEmpty) {
      return Container(
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ballColor, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "号码错误",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    List<Widget> list = _addBalls(mainNumList);
    if (subNumList.isNotEmpty) {
      list.add(const SizedBox(width: 6));
      list.add(Icon(
        Icons.add,
        color: ballColor,
        size: 18,
      ));
      list.add(const SizedBox(width: 6));
      list.addAll(_addBalls(subNumList));
    }
    return Row(children: list);
  }

  List<Widget> _addBalls(List<int> ballList) {
    List<Widget> list = [];
    for (var element in ballList) {
      if (list.isNotEmpty) {
        list.add(const SizedBox(width: 4));
      }
      list.add(Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ballColor, borderRadius: BorderRadius.circular(size)),
        child: Text(
          element.toString().padLeft(2, '0'),
          style: const TextStyle(color: Colors.white),
        ),
      ));
    }
    return list;
  }
}
