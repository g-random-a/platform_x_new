// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      budget: fields[3] as int,
      location: fields[4] as String,
      tags: (fields[5] as List).cast<String>(),
      rating: fields[7] as double,
      totalQuestions: fields[8] as int,
      completedQuestions: fields[9] as int?,
      isFavorite: fields[12] as bool,
      createdAt: fields[10] as DateTime?,
      dueDate: fields[11] as DateTime?,
      categories: (fields[6] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.totalQuestions)
      ..writeByte(9)
      ..write(obj.completedQuestions)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.dueDate)
      ..writeByte(12)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
