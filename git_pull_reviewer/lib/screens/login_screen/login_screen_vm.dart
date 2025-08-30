import 'package:flutter/foundation.dart';

import '../../db/tiken_storage.dart';

class LoginViewModel extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (username.isNotEmpty && password.isNotEmpty) {
      const fakeToken = "abc123simulatedTokenForGithub";
      await _tokenStorage.saveToken(fakeToken);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Username and password cannot be empty.";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
