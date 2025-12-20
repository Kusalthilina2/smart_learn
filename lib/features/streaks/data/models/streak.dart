import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak.freezed.dart';
part 'streak.g.dart';

@freezed
class Streak with _$Streak {
  const factory Streak({
    required int current,
    required int longest,
    required int lastActiveDate,
  }) = _Streak;

  factory Streak.fromJson(Map<String, dynamic> json) =>
      _$StreakFromJson(json);
}
