import 'package:projectmanager/common/const/enum/project_statut.dart';
import 'package:projectmanager/model/user.dart';

class Project {
  final String? id;
  final String title;
  final String description;
  final ProjectStatut statut;
  final DateTime startdate;
  final DateTime enddate;
  final User user;

  // Creation informations
  final DateTime createdat;
  final DateTime updatedat;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.createdat,
    required this.updatedat,
    required this.statut,
    required this.user,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) => print("key: $key, value: $value"));
    return Project(
      id: json.putIfAbsent('id', () => null),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      statut: ProjectStatut.statusOf(json['status'] as String),
      startdate: DateTime.parse(json['startdate']),
      enddate: DateTime.parse(json['enddate']),
      createdat: DateTime.parse(json['createdat']),
      updatedat: DateTime.parse(json['updatedat']),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'user_id': user.id,
      'status': statut.value,
      'startdate': startdate.toIso8601String(),
      'enddate': enddate.toIso8601String(),
    };
  }
}
