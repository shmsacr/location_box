import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
@HiveType(typeId: 0)
class Location with _$Location {
  @HiveField(0)
  const factory Location({
    @HiveField(1) int? id,
    @HiveField(2) double? latitude,
    @HiveField(3) double? longitude,
    @HiveField(4) String? title,
    @HiveField(5) String? description,
    @HiveField(6) String? picture,
    @HiveField(7) String? address,
    @HiveField(8) String? phoneNumber,
  }) = _Location;

  factory Location.fromJson(Map<String, Object?> json) =>
      _$LocationFromJson(json);
}
