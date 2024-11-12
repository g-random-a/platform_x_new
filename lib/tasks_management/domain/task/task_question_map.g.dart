// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_question_map.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskQuestionMapAdapter extends TypeAdapter<TaskQuestionMap> {
  @override
  final int typeId = 20;

  @override
  TaskQuestionMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskQuestionMap(
      taskId: fields[0] as String,
      questionId: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskQuestionMap obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.questionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskQuestionMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
