import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_event.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Trigger the logout event
              context.read<AuthBloc>().add(LogoutUserEvent());

              // Navigate to the login page
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Profile Details Page'),
      ),
    );
  }
}