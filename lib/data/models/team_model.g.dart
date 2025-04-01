// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamModelAdapter extends TypeAdapter<TeamModel> {
  @override
  final int typeId = 2;

  @override
  TeamModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamModel(
      name: fields[0] as String,
      score: fields[1] as int,
      correctWords: (fields[2] as List).cast<String>(),
      skippedWords: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeamModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.correctWords)
      ..writeByte(3)
      ..write(obj.skippedWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
