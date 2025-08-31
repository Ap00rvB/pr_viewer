import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pull_requests.dart';

class GithubApiService {
  final String _owner = "YOUR_GITHUB_USERNAME_OR_ORG";
  final String _repo = "YOUR_REPOSITORY_NAME";

  Future<List<PullRequest>> fetchOpenPullRequests() async {
    if (_owner == "YOUR_GITHUB_USERNAME_OR_ORG" || _repo == "YOUR_REPOSITORY_NAME") {
      throw Exception(
          "Please update _owner and _repo in github_api_service.dart "
              "to point to the actual GitHub repository for this project.");
    }

    final url = Uri.parse('https://api.github.com/repos/$_owner/$_repo/pulls?state=open');
    print('Fetching PRs from: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PullRequest.fromJson(json)).toList();
      } else {
        print('Failed to load pull requests: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load pull requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching pull requests: $e');
      throw Exception('Error fetching pull requests: $e');
    }
  }
}