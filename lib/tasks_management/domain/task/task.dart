import 'dart:math';

import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int budget;

  @HiveField(4)
  String location;

  @HiveField(5)
  List<String> tags;

  @HiveField(6)
  List<Map<String, dynamic>>? categories;

  @HiveField(7)
  double rating;

  @HiveField(8)
  int totalQuestions;

  @HiveField(9)
  int? completedQuestions;

  @HiveField(10)
  DateTime? createdAt;

  @HiveField(11)
  DateTime? dueDate;

  @HiveField(12)
  bool isFavorite;


  static final List<String> TaskFields = [
    'id',
    'title',
    'description',
    'budget',
    'location',
    'tags',
    'rating',
    'numberOfQuestions',
    'completedQuestions',
  ];
  

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.location,
    required this.tags,
    required this.rating,
    required this.totalQuestions,
    this.completedQuestions,
    this.isFavorite = false,
    this.createdAt,
    this.dueDate,
    this.categories,
  });

  factory Task.fromJson(Map<String, dynamic> json) {

    print("(((((((((((((((((((((((((((((((${json})))))))))))))))))))))))))))))))");

    Task task =  Task(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      budget: json['budget'] ?? Random().nextInt(1500),
      location: json['location'] ?? "Addis Ababa",
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      rating: json['rating'] ?? 5,
      totalQuestions: json['totalQuestions'],
      completedQuestions: json['completedQuestions'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      dueDate: DateTime.tryParse(json['dueDate']) ?? DateTime.now(),
      categories: json['categories'] != null ? List<Map<String, dynamic>>.from(json['categories']) : null,
    );

    // if (json['totalQuestions'] == null) task.totalQuestions = task.completedQuestions! + task.completedQuestions!;

    return task;


  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['budget'] = budget;
    json['location'] = location;
    json['tags'] = tags;
    json['rating'] = rating;
    json['totalQuestions'] = totalQuestions;
    json['completedQuestions'] = completedQuestions;
    json['categories'] = categories;

    return json;
  }

  @override
  String toString() {
    return "task: $title category: $categories";
  }
}