class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Convert Task to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0, // Store as integer
      'createdAt': createdAt,
    };
  }

  // Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: map['createdAt'],
    );
  }
}
