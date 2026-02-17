import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:projectmanager/model/project.dart';

class ProjectViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  ProjectViewModel();

  List<Project> _projects = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _hasNextPage = true;
  String? _errorMessage;

  List<Project> get projects => _projects;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchProjects({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 0;
      _projects = [];
      _hasNextPage = true;
    }

    if (!_hasNextPage || _isLoading) return;

    _setLoading(true);

    try {
      final from = _currentPage * _pageSize;
      final to = from + _pageSize - 1;

      final response = await _supabase
          .from('projects')
          .select('*, user:profiles(*)')
          .order('createdat', ascending: false) // Important pour garder l'ordre
          .range(from, to);

      final List<Project> newProjects = (response as List)
          .map((json) => Project.fromJson(json))
          .toList();

      if (newProjects.length < _pageSize) {
        _hasNextPage = false; // On a atteint la fin
      }

      _projects.addAll(newProjects);
      _currentPage++;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load projects: $e";
      print(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createProject(Project project) async {
    _setLoading(true);
    try {
      await _supabase.from('projects').insert(project.toJson());
      await fetchProjects();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getProject(Project project) async {
    _setLoading(true);
    try {
      final response = await _supabase
          .from('projects')
          .select('*, user:profiles(*)')
          .eq('id', project.id!);
      debugPrint(response.first.toString());
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProject(Project project) async {
    _setLoading(true);

    try {
      await _supabase
          .from('projects')
          .update(project.toJson())
          .eq("id", project.id!);
      await fetchProjects();
      return true;
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      await _supabase.from('projects').delete().eq('id', id);
      _projects.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
