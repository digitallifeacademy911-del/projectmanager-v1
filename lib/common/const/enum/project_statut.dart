enum ProjectStatut {
  notStarted('NOT_STARTED'),
  inProgress('IN_PROGRESS'),
  finished('FINISHED'),
  onPause('ON_PAUSE'),
  giveUp('GIVE_UP'),
  late('LATE');

  final String value;
  const ProjectStatut(this.value);

  static ProjectStatut statusOf(String value) {
    return ProjectStatut.values.firstWhere((v) => v.value == value);
  }
}
