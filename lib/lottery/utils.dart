class Utils {
  Utils._();

  static final List<String> _weekList = [
    "",
    "星期一",
    "星期二",
    "星期三",
    "星期四",
    "星期五",
    "星期六",
    "星期天"
  ];

  static String nextDraw(List<int> drawList) {
    var now = DateTime.now();
    var weekday = now.weekday;
    var desc = "";
    for (int i = 0; i < drawList.length - 1; i++) {
      var pre = drawList[i];
      var last = drawList[i + 1];
      if (weekday == pre || weekday == last) {
        desc = "今天 ${_weekList[weekday]}";
        break;
      }
      if (weekday > pre && weekday < last) {
        var interval = last - weekday;
        if (interval == 1) {
          desc = "明天 ${_weekList[last]}";
        } else if (interval == 2) {
          desc = "后天 ${_weekList[last]}";
        } else {
          desc = "$interval天后 ${_weekList[last]}";
        }
      }
    }
    return "下次开奖是 $desc";
  }
}
