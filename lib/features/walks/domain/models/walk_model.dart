
class Walk {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String notes;

  Walk({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.notes,
  });

  Walk copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
  }) {
    return Walk(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'notes': notes,
    };
  }

  factory Walk.fromJson(Map<String, dynamic> json) {
    return Walk(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      notes: json['notes'] as String,
    );
  }
}
