import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:projectmanager/model/user.dart';

class AuthViewmodel extends ChangeNotifier {
  final Supabase supabase;
  AuthViewmodel(this.supabase);

  Future<User?> login(String email, String password) async {
    try {
      final response = await supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      return User(response.user!.email!);
    } on AuthException catch (e) {
      throw Exception('Error on auth : ${e.message}');
    }
  }
}
