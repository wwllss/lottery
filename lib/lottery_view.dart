import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/utils.dart';

class LotteryView extends StatefulWidget {
  final Lottery _lottery;
  final List<int> mbs;
  final List<int> sbs;
  final int _size;

  LotteryView(this._lottery,
      {super.key, List<int>? mbs, List<int>? sbs, int? size})
      : mbs = List<int>.from(mbs ?? []),
        sbs = List<int>.from(sbs ?? []),
        _size = size ?? 35;

  @override
  State<StatefulWidget> createState() {
    return _LotteryViewState();
  }
}

class _LotteryViewState extends State<LotteryView> {
  @override
  Widget build(BuildContext context) {
    LotteryConfig config = widget._lottery.config();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "前区：最少${config.main.minNum}个",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _getBalls(config.main, widget.mbs),
          ),
          const SizedBox(height: 12),
          Text(
            "后区：最少${config.sub.minNum}个",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _getBalls(config.sub, widget.sbs),
          ),
        ],
      ),
    );
  }

  List<Widget> _getBalls(BallConfig config, List<int> selectedBalls) {
    return config.balls
        .map((e) => LotteryBallView(
            config: config,
            value: e,
            selected: selectedBalls.contains(e),
            size: widget._size,
            onPressed: (value) {
              if (selectedBalls.contains(e)) {
                selectedBalls.remove(e);
              } else {
                selectedBalls.add(e);
              }
              setState(() {});
            }))
        .toList();
  }
}

class LotteryBallView extends StatefulWidget {
  final BallConfig config;
  final int value;
  final bool selected;
  final int size;
  final void Function(int value) onPressed;

  const LotteryBallView(
      {super.key,
      required this.config,
      required this.value,
      required this.selected,
      required this.size,
      required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _LotteryBallViewState();
  }
}

class _LotteryBallViewState extends State<LotteryBallView> {
  @override
  Widget build(BuildContext context) {
    double size = widget.size.toDouble();
    BorderRadius borderRadius = BorderRadius.circular(size);
    BoxDecoration bd = widget.selected
        ? BoxDecoration(
            color: widget.config.color,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          );
    TextStyle ts = widget.selected
        ? const TextStyle(
            color: Colors.white,
          )
        : const TextStyle(
            color: BallColors.black_333,
          );
    return InkWell(
      onTap: () {
        widget.onPressed(widget.value);
      },
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: bd,
        child: Text(
          Utils.formatBall(widget.value),
          style: ts,
        ),
      ),
    );
  }
}
