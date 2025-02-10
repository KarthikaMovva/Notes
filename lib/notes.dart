class Note {
  final int id; 
  final String body;
  final String userId; 
  final DateTime createdAt;

  Note({
    required this.id,
    required this.body,
    required this.userId,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: (json['id'] as num).toInt(),  
      body: json['body'] ?? '',          
      userId: json['user_id'] as String, 
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  
      'body': body,
      'user_id': userId, 
      'created_at': createdAt.toIso8601String(),
    };
  }
}
