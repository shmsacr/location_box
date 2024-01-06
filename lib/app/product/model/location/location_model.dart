import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
@HiveType(typeId: 0)
class LocationModel with _$LocationModel {
  @HiveField(0)
  const factory LocationModel({
    @HiveField(1) String? id,
    @HiveField(2) double? latitude,
    @HiveField(3) double? longitude,
    @HiveField(4) String? title,
    @HiveField(5) String? description,
    @HiveField(6) String? picture,
    @HiveField(7) String? address,
    @HiveField(8) String? phoneNumber,
    @HiveField(9) DateTime? createdAt,
    @HiveField(10) String? iconPath,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, Object?> json) =>
      _$LocationModelFromJson(json);
}
