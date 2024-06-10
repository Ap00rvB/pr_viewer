
class EventModel {
  final String createdAt;
  final String title;
  final String description;
  final String status;
  final String startAt;
  final int duration;
  final String id;

  EventModel({
    required this.createdAt,
    required this.title,
    required this.description,
    required this.status,
    required this.startAt,
    required this.duration,
    required this.id,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      createdAt: json['createdAt'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      startAt: json['startAt'],
      duration: json['duration'],
      id: json['id'],
    );
  }
}