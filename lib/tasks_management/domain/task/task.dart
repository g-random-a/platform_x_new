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
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      location: json['location'],
      tags: List<String>.from(json['tags']),
      rating: json['rating'],
      totalQuestions: json['numberOfQuestions'],
      completedQuestions: json['completedQuestions'],
    );
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