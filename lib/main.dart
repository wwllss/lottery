import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottery/routes.dart';

import 'enums.dart';
import 'lottery_group.dart';

void main() {
  runApp(const LotteryApp());
}

class LotteryApp extends StatelessWidget {
  const LotteryApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '一注幸运',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LotteryHome(),
      onGenerateRoute: Routes.make,
    );
  }
}

class LotteryHome extends StatefulWidget {
  const LotteryHome({super.key});

  @override
  State<LotteryHome> createState() => _LotteryHomeState();
}

class _LotteryHomeState extends State<LotteryHome> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('一注幸运'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "福 彩"),
              Tab(text: "体 彩"),
            ],
            labelStyle: TextStyle(fontSize: 16),
          ),
        ),
        body: TabBarView(children: [
          LotteryGroupView(Lottery.welfareList),
          LotteryGroupView(Lottery.sportList),
        ]), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
