import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_event.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_state.dart';
class VerifyPage extends StatelessWidget {
  final String email; // Add email as a parameter
  final TextEditingController _codeController = TextEditingController();

  VerifyPage({required this.email}); // Require email in the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Code'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailVerifiedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email verified successfully!')),
            );
            Navigator.pushReplacementNamed(context, '/signin');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Verification Code',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final code = _codeController.text.trim();
                    if (code.isNotEmpty) {
                      context.read<AuthBloc>().add(
                            VerifyEmailEvent(email, code), // Use the dynamic email
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter the verification code'),
                        ),
                      );
                    }
                  },
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                   
                  },
                  child: const Text('Resend Verification Email'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}