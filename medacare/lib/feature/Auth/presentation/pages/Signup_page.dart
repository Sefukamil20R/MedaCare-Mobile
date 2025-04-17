import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_event.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_state.dart';
import 'package:medacare/feature/Auth/presentation/pages/verify_page.dart';

import '../../domain/entitiy/user_entity.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                if (state is RegisteredState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')),
                  );
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => VerifyPage(email: _emailController.text), // Pass the email
  ),
);                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
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
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D586E),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // First Name
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Color(0xFF1D586E)),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D586E)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Last Name
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(color: Color(0xFF1D586E)),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D586E)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Color(0xFF1D586E)),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D586E)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF1D586E)),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D586E)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: Color(0xFF1D586E)),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1D586E)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign Up Button
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
                          Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => VerifyPage(email: _emailController.text), // Pass the email
  ),
);
                          final firstName = _firstNameController.text.trim();
                          final lastName = _lastNameController.text.trim();
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          final confirmPassword =
                              _confirmPasswordController.text.trim();

                          if (firstName.isEmpty ||
                              lastName.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill in all fields'),
                              ),
                            );
                            return;
                          }

                          if (password != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }

                          context.read<AuthBloc>().add(
                                RegisterUserEvent(
                                  User(
                                    id: '', // ID will be generated by the server
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                  ),
                                ),
                              );
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Already have account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Color(0xFFA55D68),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
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