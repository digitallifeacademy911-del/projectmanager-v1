import 'package:flutter/material.dart';
import 'package:projectmanager/view/widgets/projects/project_card.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Charger la première page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectViewModel>().fetchProjects(isRefresh: true);
    });

    // Écouter le scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // On est à 200px du bas, on charge la suite
        context.read<ProjectViewModel>().fetchProjects();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectViewModel>();

    return ListView.builder(
      controller: _scrollController,
      itemCount: vm.projects.length + (vm.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < vm.projects.length) {
          return ProjectCard(project: vm.projects[index]);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
