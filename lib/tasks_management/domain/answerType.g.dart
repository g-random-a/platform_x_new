// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answerType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ValueAnswerAdapter extends TypeAdapter<ValueAnswer> {
  @override
  final int typeId = 2;

  @override
  ValueAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ValueAnswer(
      id: fields[0] as int,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ValueAnswer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InputOptionsAdapter extends TypeAdapter<InputOptions> {
  @override
  final int typeId = 7;

  @override
  InputOptions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InputOptions(
      id: fields[0] as int,
      value: fields[1] as String,
      valueType: fields[2] as String,
    )..selected = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, InputOptions obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.valueType)
      ..writeByte(3)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SelectionAnswerAdapter extends TypeAdapter<SelectionAnswer> {
  @override
  final int typeId = 3;

  @override
  SelectionAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectionAnswer(
      id: fields[0] as int,
      selected: (fields[1] as List).cast<InputOptions>(),
    );
  }

  @override
  void write(BinaryWriter writer, SelectionAnswer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectionAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RangeAnswerAdapter extends TypeAdapter<RangeAnswer> {
  @override
  final int typeId = 4;

  @override
  RangeAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RangeAnswer(
      id: fields[0] as int,
      startValue: fields[1] as num,
      endValue: fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, RangeAnswer obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startValue)
      ..writeByte(2)
      ..write(obj.endValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RangeAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FileAnswerAdapter extends TypeAdapter<FileAnswer> {
  @override
  final int typeId = 5;

  @override
  FileAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileAnswer(
      id: fields[0] as int,
      file: (fields[1] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, FileAnswer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnswerFormatAdapter extends TypeAdapter<AnswerFormat> {
  @override
  final int typeId = 6;

  @override
  AnswerFormat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerFormat(
      userId: fields[0] as String,
      questionId: fields[1] as String,
      answers: (fields[2] as List).cast<IAnswer>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnswerFormat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerFormatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
