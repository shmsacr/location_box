// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  final int typeId = 1;

  @override
  AppState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppState(
      themeMode: fields[1] as bool,
      languageCode: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.themeMode)
      ..writeByte(2)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppStateImpl _$$AppStateImplFromJson(Map<String, dynamic> json) =>
    _$AppStateImpl(
      themeMode: json['themeMode'] as bool? ?? false,
      languageCode: json['languageCode'] as String?,
    );

Map<String, dynamic> _$$AppStateImplToJson(_$AppStateImpl instance) =>
    <String, dynamic>{
      'themeMode': instance.themeMode,
      'languageCode': instance.languageCode,
    };
