import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/common/utils/navigator_utils.dart';
import 'package:projectmanager/view/widgets/projects/project_card.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectList> with RouteAware {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // On enregistre cette page auprès de l'observateur
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); // Important : on se désabonne
    super.dispose();
  }

  @override
  void didPopNext() {
    // Cette méthode est appelée quand on revient sur cette page
    print("On est revenu sur la liste ! Rafraîchissement...");
    context.read<ProjectViewModel>().fetchProjects(isRefresh: true);
  }

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

    return (vm.projects.isEmpty)
        ? Center(
            child: Text(
              'No projects saved',
              style: AppFont.karla.copyWith(
                fontSize: AppConst.h2,
                color: PalleteColor.whiteWeak,
              ),
            ),
          )
        : ListView.builder(
            controller: _scrollController,
            itemCount: vm.projects.length + (vm.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < vm.projects.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ProjectCard(project: vm.projects[index]),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }
}
