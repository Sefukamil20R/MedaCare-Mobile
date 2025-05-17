import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Auth/presentation/bloc/auth_bloc.dart';
import '../../../Auth/presentation/bloc/auth_state.dart';

class TopGreeting extends StatelessWidget {
  const TopGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/Avatar.png'),
          ),
          const SizedBox(width: 12),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String firstName = 'User';
              if (state is UserProfileLoadedState) {
                firstName = state.user.firstName ?? 'User';
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $firstName',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Good Morning',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}