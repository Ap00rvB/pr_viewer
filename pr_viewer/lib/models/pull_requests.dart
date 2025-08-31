// lib/core/models/pull_request.dart
class PullRequest {
  final String title;
  final String? body;
  final String authorUsername;
  final DateTime createdAt;
  final String htmlUrl; // To open PR in browser

  PullRequest({
    required this.title,
    this.body,
    required this.authorUsername,
    required this.createdAt,
    required this.htmlUrl,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      title: json['title'] ?? 'No Title',
      body: json['body'],
      authorUsername: json['user']?['login'] ?? 'Unknown User',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      htmlUrl: json['html_url'] ?? '',
    );
  }
}