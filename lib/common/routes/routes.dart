import 'package:flutter/material.dart';
import 'package:projectmanager/view/pages/auth/login.dart';
import 'package:projectmanager/view/pages/auth/signup.dart';
import 'package:projectmanager/view/pages/authenticated/projects.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => ProjectsPage(),
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
};

class Routes extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    
  }
}