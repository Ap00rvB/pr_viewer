import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../models/pull_requests.dart';
import '../../services/api_service.dart';

enum PrListState { initial, loading, loaded, error }

class PrListViewModel extends ChangeNotifier {
  final GithubApiService _apiService = GithubApiService();

  PrListState _state = PrListState.initial;

  PrListState get state => _state;
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  List<PullRequest> _pullRequests = [];

  List<PullRequest> get pullRequests => _pullRequests;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _storedToken;

  String? get storedToken => _storedToken;

  PrListViewModel() {
    fetchPullRequests();
  }

  Future<void> fetchPullRequests() async {
    if (_isBusy) {
      return;
    }
    _isBusy = true;
    notifyListeners();
    var response = await get(Uri.parse(
        " "));

    final List<dynamic> prData = jsonDecode(response.body);
    _pullRequests =
        prData.map((data) => PullRequest.fromJson(data)).toList();
    _isBusy = false;
    notifyListeners();
/*

    _state = PrListState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _pullRequests = await _apiService.fetchOpenPullRequests();
      _state = PrListState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = PrListState.error;
    }
    notifyListeners();
  }*/
  }
}
