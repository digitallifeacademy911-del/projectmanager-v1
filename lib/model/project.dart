import 'package:flutter/widgets.dart';
import 'package:projectmanager/common/const/enum/project_statut.dart';
import 'package:projectmanager/model/user.dart';

class Project {
  String? _id;
  String title;
  String description;
  ProjectStatut status;
  DateTime? startdate;
  DateTime? enddate;
  final User? user;

  // Creation informations
  final DateTime? createdat;
  final DateTime? updatedat;

  Project({
    String? id,
    required this.title,
    required this.description,
    this.startdate,
    this.enddate,
    this.createdat,
    this.updatedat,
    required this.status,
    this.user,
  }) {
    _id = id;
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: ProjectStatut.statusOf(json['status'] as String),
      startdate: DateTime.parse(json['startdate']),
      enddate: DateTime.parse(json['enddate']),
      createdat: DateTime.parse(json['createdat']),
      updatedat: DateTime.parse(json['updatedat']),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    ).._id = json.putIfAbsent('id', () => null);
  }

  Map<String, dynamic> toJson() {
    debugPrint(user?.id);
    return {
      if (_id != null) 'id': _id,
      'title': title,
      'description': description,
      'user_id': user?.id ?? '',
      'status': status.value,
      'startdate': startdate?.toIso8601String(),
      'enddate': enddate?.toIso8601String(),
    };
  }

  String? get id => _id;
  set id(String id) {
    _id = id;
  }
}
