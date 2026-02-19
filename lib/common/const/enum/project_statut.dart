import 'package:flutter/material.dart';
import 'package:projectmanager/common/theme/pallette.dart';

enum ProjectStatut {
  notStarted('NOT_STARTED', PalleteColor.projectNotStarted, false),
  inPlanning('IN_PLANNING', PalleteColor.projectInPlanning),
  inProgress('IN_PROGRESS', PalleteColor.projectInProgress),
  finished('FINISHED', PalleteColor.projectFinished),
  onPause('ON_PAUSE', PalleteColor.projectOnPause),
  giveUp('GIVE_UP', PalleteColor.projectGiveUp),
  late('LATE', PalleteColor.projectInLate, false);

  final String value;
  final Color color;
  final bool isSelectable;
  const ProjectStatut(this.value, this.color, [this.isSelectable = true]);

  static ProjectStatut statusOf(String value) {
    return ProjectStatut.values.firstWhere((v) => v.value == value);
  }
}
