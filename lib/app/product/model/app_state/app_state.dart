import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';
@freezed
@HiveType(typeId: 1)
class AppState with _$AppState{
  @HiveField(0)
  const factory AppState({
    @Default(false)@HiveField(1) bool themeMode,
    @HiveField(2) String? languageCode,
    
  }) = _AppState;
  factory AppState.fromJson(Map<String, Object?> json) =>
      _$AppStateFromJson(json);
}