import 'package:flutter/material.dart';
import 'package:lottery/ball_colors.dart';
import 'package:lottery/enums.dart';
import 'package:lottery/lottery_view.dart';
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
  LotteryResult? newestHistory;
  LotteryResult? _killedBalls;
  List<dynamic> selectedList = [];
  bool _duplex = false;
  int _duplexMain = 0;
  int _duplexSub = 0;

  int _count = 1;

  @override
  void initState() {
    _duplexMain = widget.lottery.config().main.minNum;
    _duplexSub = widget.lottery.config().sub.minNum;
    Utils.historyList(widget.lottery.type, (list) {
      if (list.isNotEmpty) {
        setState(() {
          newestHistory = list[0];
          _killedBalls = LotteryResult(
              List<int>.from(newestHistory?.mainNumbers ?? []),
              List<int>.from(newestHistory?.bonusNumbers ?? []),
              newestHistory?.drawDate ?? "");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LotteryConfig config = widget.lottery.config();
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
                    : Expanded(
                        child: LotteryNumberView(
                          lottery: widget.lottery,
                          mainNumList: newestHistory?.mainNumbers ?? [],
                          subNumList: newestHistory?.bonusNumbers ?? [],
                          size: 25,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                _showKillNumberDialog();
              },
              child: Row(
                children: [
                  const Text(
                    "杀号：",
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: LotteryNumberView(
                      lottery: widget.lottery,
                      mainNumList: _killedBalls?.mainNumbers ?? [],
                      subNumList: _killedBalls?.bonusNumbers ?? [],
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var history = selectedList[index];
                    if (history is LotteryResult) {
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
                _onTapDuplex(!_duplex);
              },
              child: Row(
                children: [
                  Switch(
                    value: _duplex,
                    onChanged: (value) {
                      _onTapDuplex(value);
                    },
                  ),
                  Text(
                    "复式 $_duplexMain  ${config.sub.minNum == 0 ? "" : "+ $_duplexSub"}",
                    style: const TextStyle(color: Colors.white),
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
                              killed: _killedBalls,
                              duplexMain: _duplex ? _duplexMain : null,
                              duplexSub: _duplex ? _duplexSub : null,
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
                              killed: _killedBalls,
                              duplexMain: _duplex ? _duplexMain : null,
                              duplexSub: _duplex ? _duplexSub : null,
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
                              killed: _killedBalls,
                              duplexMain: _duplex ? _duplexMain : null,
                              duplexSub: _duplex ? _duplexSub : null,
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

  void _newSelectedList(List<LotteryResult> list, String desc) {
    selectedList.insertAll(0, list);
    var history = list[0];
    var config = widget.lottery.config();
    var total = Utils.combine(history.mainNumbers.length, config.main.minNum)
            .length *
        Utils.combine(history.bonusNumbers.length, config.sub.minNum).length;
    selectedList.insert(0, "第${_count++}次，$desc，每注${total * 2}元");
  }

  void _onTapDuplex(bool value) {
    if (!value) {
      setState(() {
        _duplex = !_duplex;
      });
      return;
    }
    showDialog<bool>(context: context, builder: _showDuplexDialog)
        .then((value) {
      if (value ?? false) {
        setState(() {
          _duplex = true;
        });
      }
    });
  }

  Widget _showDuplexDialog(BuildContext context) {
    var config = widget.lottery.config();
    int totalNum = config.main.minNum + config.sub.minNum + 1;
    GlobalKey formKey = GlobalKey<FormState>();
    TextEditingController mainController =
        TextEditingController(text: _duplexMain.toString());
    TextEditingController subController =
        TextEditingController(text: _duplexSub.toString());
    return AlertDialog(
      title: const Text("复 式"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              controller: mainController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "前区数：",
                hintText: "不小于${config.main.minNum}",
              ),
              validator: (value) {
                value = value ?? "";
                if (value.isEmpty) {
                  return "前区数不能为空";
                }
                var main = int.parse(value);
                if (main < config.main.minNum) {
                  return "前区数不能小于${config.main.minNum}";
                }
                if (main + int.parse(subController.text) < totalNum) {
                  return "与后区数想加不能小于$totalNum";
                }
                return null;
              },
            ),
            config.sub.minNum == 0
                ? const SizedBox(
                    width: 0,
                    height: 0,
                  )
                : TextFormField(
                    controller: subController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "后区数：",
                      hintText: "不小于${config.sub.minNum}",
                    ),
                    validator: (value) {
                      value = value ?? "";
                      if (value.isEmpty) {
                        return "后区数不能为空";
                      }
                      var sub = int.parse(value);
                      if (sub < config.sub.minNum) {
                        return "后区数不能小于${config.sub.minNum}";
                      }
                      if (sub + int.parse(mainController.text) < totalNum) {
                        return "与前区数想加不能小于$totalNum";
                      }
                      return null;
                    },
                  ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: () {
            if ((formKey.currentState as FormState).validate()) {
              _duplexMain = int.parse(mainController.text);
              _duplexSub = int.parse(subController.text);
              Navigator.of(context).pop(true);
            }
          },
          child: const Text("确定"),
        ),
      ],
    );
  }

  void _showKillNumberDialog() {
    LotteryView lotteryView = LotteryView(
      widget.lottery,
      mbs: _killedBalls?.mainNumbers,
      sbs: _killedBalls?.bonusNumbers,
    );
    showModalBottomSheet<LotteryResult>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 600,
          color: BallColors.bg_content,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: BallColors.bg_content,
                elevation: 10,
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: const Text(
                    "请选择号码",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: lotteryView,
                ),
              ),
              InkWell(
                onTap: () {
                  if (lotteryView.mbs.isEmpty && lotteryView.sbs.isEmpty) {
                    return;
                  }
                  Navigator.of(context).pop(LotteryResult(lotteryView.mbs,
                      lotteryView.sbs, newestHistory?.drawDate ?? ""));
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: BallColors.bb,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: const Text(
                    "确 定",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _killedBalls = value;
        });
      }
    });
  }
}
