import 'package:flutter/material.dart';
import 'package:projectmanager/view/pages/auth/login.dart';
import 'package:projectmanager/view/pages/authenticated/projects.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, state) {
        if (state.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if ((state.hasData ? state.data?.session : null) != null) {
          return ProjectsPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
