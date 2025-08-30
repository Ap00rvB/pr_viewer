import 'package:flutter/material.dart';
import '../pr_list_screen/pr_list_screen.dart';
import 'login_screen_vm.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    _loginViewModel.addListener(_onViewModelUpdate);
  }

  void _onViewModelUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _attemptLogin() async {
    final success = await _loginViewModel.login(
      _usernameController.text,
      _passwordController.text,
    );
    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed(PrListScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulated Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username (any)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password (any)'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_loginViewModel.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _attemptLogin,
                child: const Text('Login'),
              ),
            if (_loginViewModel.errorMessage != null) ...[
              const SizedBox(height: 15),
              Text(
                _loginViewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _loginViewModel.removeListener(_onViewModelUpdate);
    _loginViewModel.dispose();
    super.dispose();
  }
}
