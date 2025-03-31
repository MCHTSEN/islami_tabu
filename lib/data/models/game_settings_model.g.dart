// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameSettingsModelAdapter extends TypeAdapter<GameSettingsModel> {
  @override
  final int typeId = 1;

  @override
  GameSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameSettingsModel(
      gameDuration: fields[0] as int,
      passPenalty: fields[1] as int,
      maxPasses: fields[2] as int,
      selectedCategory: fields[3] as String,
      shuffleWords: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GameSettingsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.gameDuration)
      ..writeByte(1)
      ..write(obj.passPenalty)
      ..writeByte(2)
      ..write(obj.maxPasses)
      ..writeByte(3)
      ..write(obj.selectedCategory)
      ..writeByte(4)
      ..write(obj.shuffleWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
