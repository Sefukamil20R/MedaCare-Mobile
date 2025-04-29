import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';


class VerifyPage extends StatefulWidget {
  final String email;

  const VerifyPage({super.key, required this.email});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is EmailVerifiedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email verified successfully!')),
                  );
                  Navigator.pushReplacementNamed(context, '/signin');
                } else if (state is AuthError) {
                  if (state.message.contains('already verified')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User is already verified. Please log in.')),
                    );
                    Navigator.pushReplacementNamed(context, '/verify_success');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                }
              },
             builder: (context, state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 16),

      // Logo
      Image.asset(
        'assets/images/medaCare_logo.png',
        height: 80,
      ),

      const SizedBox(height: 16),

      // Title
      const Text(
        'Email Verification',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1D586E),
        ),
      ),

      const SizedBox(height: 24),

      // Code input
      TextFormField(
        controller: _codeController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        decoration: const InputDecoration(
          labelText: 'Enter 6-digit Code',
          labelStyle: TextStyle(color: Color(0xFF1D586E)),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1D586E)),
          ),
        ),
      ),

      const SizedBox(height: 24),

      // Submit Button
      SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA55D68),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            final code = _codeController.text.trim();
            if (code.isNotEmpty && code.length == 6) {
              context.read<AuthBloc>().add(
                    VerifyEmailEvent(widget.email, code),
                  );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter the 6-digit code'),
                ),
              );
            }
          },
          child: state is VerifyLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'VERIFY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),

      const SizedBox(height: 20),

      // Resend Button
      TextButton(
        onPressed: () {
          context.read<AuthBloc>().add(
                ResendVerificationEmailEvent(widget.email),
              );
        },
        child: state is ResendEmailLoading
            ? const CircularProgressIndicator(color: Color(0xFFA55D68))
            : const Text(
                'Resend Verification Email',
                style: TextStyle(
                  color: Color(0xFFA55D68),
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),

      const SizedBox(height: 16),
    ],
  );
},
            ),
          ),
        ),
      ),
    );
  }
}
