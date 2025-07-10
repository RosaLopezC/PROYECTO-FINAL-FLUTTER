class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isCompleted;
  final String priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.completedAt,
    this.isCompleted = false,
    this.priority = 'medium',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      completedAt: map['completedAt'] != null 
          ? DateTime.parse(map['completedAt']) 
          : null,
      isCompleted: map['isCompleted'] == 1,
      priority: map['priority'] ?? 'medium',
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isCompleted,
    String? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}