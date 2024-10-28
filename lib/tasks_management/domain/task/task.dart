import 'dart:math';

class Task {
  String id;
  String title;
  String description;
  int budget;
  String location;
  List<String> tags;
  double rating;
  int totalQuestions;
  int? completedQuestions;
  DateTime? createdAt;
  DateTime? dueDate;
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
  });

  factory Task.fromJson(Map<String, dynamic> json) {

    Task task =  Task(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'] ?? Random().nextInt(1500),
      location: json['location'] ?? "Addis Ababa",
      tags: json['tags'] != null ? List<String>.from(json['tags']) : 
      [
        "18-34+",
        "Marketing",
        "Sales",
        "Business",
        "Finance",
        "Accounting",
        "Management",
        "Human Resource",
        "Customer Service",
        "Information Technology",
        "Engineering",
        "Healthcare",
        "Education",
      ].sublist(Random().nextInt(5)),
      rating: json['rating'] ?? Random().nextDouble() * 5,
      totalQuestions: json['numberOfQuestions'] ?? Random().nextInt(15) + 1,
      completedQuestions: json['completedQuestions'] ?? Random().nextInt(15) + 1,
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      dueDate: DateTime.tryParse(json['dueDate']) ?? DateTime.now()
    );

    task.totalQuestions = task.completedQuestions! + task.completedQuestions!;

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
    json['numberOfQuestions'] = totalQuestions;
    json['completedQuestions'] = completedQuestions;

    return json;
  }

  @override
  String toString() {
    return "task: $title";
  }
}