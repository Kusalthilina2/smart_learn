import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/constants/strings.dart';
import '../../data/repositories/auth_repository.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _childNameController = TextEditingController();
  final _parentEmailController = TextEditingController();
  int _selectedGrade = 1;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _childNameController.dispose();
    _parentEmailController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential =
          await ref.read(authRepositoryProvider).signUpWithEmailPassword(
                _emailController.text.trim(),
                _passwordController.text,
              );

      await ref.read(authRepositoryProvider).createUserProfile(
            uid: credential.user!.uid,
            email: _emailController.text.trim(),
            childName: _childNameController.text.trim(),
            grade: _selectedGrade,
            parentEmail: _parentEmailController.text.trim(),
          );

      // Wait and verify profile was created with retry logic
      bool profileCreated = false;
      for (int attempt = 0; attempt < 5; attempt++) {
        await Future.delayed(Duration(milliseconds: 500 + (attempt * 200)));
        final profile = await ref.read(authRepositoryProvider).getUserProfile(credential.user!.uid);
        if (profile != null) {
          profileCreated = true;
          break;
        }
      }
      
      if (!profileCreated && mounted) {
        throw Exception('Failed to create user profile. Please try signing in.');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Sign up failed: ${e.toString()}';
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.signUp,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _childNameController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.childName,
                      prefixIcon: Icon(Icons.child_care),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    initialValue: _selectedGrade,
                    decoration: const InputDecoration(
                      labelText: AppStrings.grade,
                      prefixIcon: Icon(Icons.school),
                    ),
                    items: List.generate(5, (i) => i + 1)
                        .map((grade) => DropdownMenuItem(
                              value: grade,
                              child: Text('Grade $grade'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGrade = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.password,
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _parentEmailController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.parentEmail,
                      prefixIcon: Icon(Icons.supervisor_account),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signUp,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(AppStrings.signUp),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/signin'),
                    child: const Text('Already have an account? Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
