import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'VerifyCodePage.dart';

class SendResetEmailPage extends StatefulWidget {
  const SendResetEmailPage({super.key});

  @override
  State<SendResetEmailPage> createState() => _SendResetEmailPageState();
}

class _SendResetEmailPageState extends State<SendResetEmailPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/MedaCare_Gradient.png', fit: BoxFit.cover),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is ResetPasswordEmailSent) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyCodePage(email: _emailController.text.trim()),
                      ),
                    );
                  } else if (state is ResetPasswordError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/medaCare_logo.png', height: 60),
                      const SizedBox(height: 32),
                      const Text("Reset Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1D586E))),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFA55D68),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: state is ResetPasswordLoading
                              ? null
                              : () {
                                  final email = _emailController.text.trim();
                                  if (email.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter your email')),
                                    );
                                    return;
                                  }
                                  context.read<AuthBloc>().add(SendResetPasswordEmailEvent(email));
                                },
                          child: state is ResetPasswordLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("SEND CODE", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}