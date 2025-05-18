import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'reset_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  final String email;
  const VerifyCodePage({super.key, required this.email});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController _codeController = TextEditingController();

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
                  if (state is ResetPasswordCodeVerified) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPasswordPage(email: widget.email),
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
                      const Text("Enter Verification Code", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1D586E))),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '6-digit Code',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        maxLength: 6,
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
                                  final code = _codeController.text.trim();
                                  if (code.length != 6) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter the 6-digit code')),
                                    );
                                    return;
                                  }
                                  context.read<AuthBloc>().add(VerifyResetCodeEvent(widget.email, code));
                                },
                          child: state is ResetPasswordLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("VERIFY CODE", style: TextStyle(fontSize: 16, color: Colors.white)),
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