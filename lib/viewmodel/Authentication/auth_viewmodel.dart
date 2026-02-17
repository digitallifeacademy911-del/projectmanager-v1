import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:projectmanager/model/user.dart';

class AuthViewmodel extends ChangeNotifier {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  AuthViewmodel();

  Future<User?> login(String email, String password) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      return User(email: response.user!.email!, id: response.user!.id);
    } on AuthException catch (e) {
      throw Exception('Error on auth : ${e.message}');
    }
  }

  Future<User?> signup(String email, String password) async {
    try {
      await supabaseClient.auth.signUp(email: email, password: password);
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return User(email: response.user!.email!, id: response.user!.id);
    } on AuthException catch (e) {
      throw Exception(
        'Error on signup: ${e.message}\nStatus code: ${e.statusCode}',
      );
    }
  }

  // Ici j'utilise une lambda expression pour effectuer la déconnexion
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      print('Error on logout : ${e.message}');
    }
  }

  Future<User?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    return (user != null) ? User(email: user.email!, id: user.id) : null;
  }
}
