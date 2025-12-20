import 'dart:math';

class Levenshtein {
  static int distance(String s1, String s2) {
    final len1 = s1.length;
    final len2 = s2.length;
    final dist = List.generate(
      len1 + 1,
      (i) => List.filled(len2 + 1, 0),
    );

    for (var i = 0; i <= len1; i++) {
      dist[i][0] = i;
    }
    for (var j = 0; j <= len2; j++) {
      dist[0][j] = j;
    }

    for (var i = 1; i <= len1; i++) {
      for (var j = 1; j <= len2; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dist[i][j] = min(
          min(dist[i - 1][j] + 1, dist[i][j - 1] + 1),
          dist[i - 1][j - 1] + cost,
        );
      }
    }

    return dist[len1][len2];
  }

  static double similarity(String s1, String s2) {
    final maxLen = max(s1.length, s2.length);
    if (maxLen == 0) return 1.0;
    final dist = distance(s1.toLowerCase(), s2.toLowerCase());
    return 1.0 - (dist / maxLen);
  }
}
