// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_statistics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStatisticsModelAdapter extends TypeAdapter<GameStatisticsModel> {
  @override
  final int typeId = 3;

  @override
  GameStatisticsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStatisticsModel(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      gameDuration: fields[2] as int,
      totalWords: fields[3] as int,
      totalCorrectWords: fields[4] as int,
      totalSkippedWords: fields[5] as int,
      teams: (fields[6] as List).cast<TeamModel>(),
      winningTeam: fields[7] as String,
      highestScore: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameStatisticsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.gameDuration)
      ..writeByte(3)
      ..write(obj.totalWords)
      ..writeByte(4)
      ..write(obj.totalCorrectWords)
      ..writeByte(5)
      ..write(obj.totalSkippedWords)
      ..writeByte(6)
      ..write(obj.teams)
      ..writeByte(7)
      ..write(obj.winningTeam)
      ..writeByte(8)
      ..write(obj.highestScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStatisticsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
