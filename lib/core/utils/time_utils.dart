class TimeUtils {
  static int nowMs() => DateTime.now().millisecondsSinceEpoch;

  static DateTime fromMs(int ms) =>
      DateTime.fromMillisecondsSinceEpoch(ms);

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
