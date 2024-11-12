import 'package:hive/hive.dart';

part 'task_question_map.g.dart';

@HiveType(typeId: 20)
class TaskQuestionMap {

  @HiveField(0)
  String taskId;

  @HiveField(1)
  List<String> questionId;

  static final List<String> TaskQuestionMapFields = [
    'taskId',
    'questionId',
  ];
  

  TaskQuestionMap({
    required this.taskId,
    required this.questionId,
  });
}