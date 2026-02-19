import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/common/utils/navigator_utils.dart';
import 'package:projectmanager/common/utils/page_transition.dart';
import 'package:projectmanager/view/pages/authenticated/project_create_and_update_page.dart';
import 'package:projectmanager/view/widgets/projects/project_list.dart';
import 'package:projectmanager/viewmodel/Authentication/auth_viewmodel.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

// Utilisation de RouteAware pour rafraîchir au retour
class _ProjectsPageState extends State<ProjectsPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // On s'abonne à l'observateur (défini globalement comme vu précédemment)
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Rafraîchit la liste quand on revient sur cette page
    context.read<ProjectViewModel>().fetchProjects(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    // On surveille l'état via context.watch pour reconstruire l'UI
    final viewModel = context.watch<ProjectViewModel>();
    final authvm = context.watch<AuthViewmodel>();

    return Scaffold(
      backgroundColor: PalleteColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => authvm.logout(),
            icon: Icon(Icons.logout_outlined, color: PalleteColor.white),
          ),
        ],
        leading: null,
        title: Text(
          'Projects',
          style: AppFont.karla.copyWith(
            color: PalleteColor.white,
            fontSize: AppConst.h2,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SafeArea(
        // Ajout du SafeArea pour éviter l'encoche/barre d'état
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Header Section

            // Main Content Area (Le conteneur blanc)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: PalleteColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: AppConst.bodyRadius,
                    topRight: AppConst.bodyRadius,
                  ),
                ),
                // Logique d'affichage Conditionnelle
                child: RefreshIndicator(
                  onRefresh: () => viewModel.fetchProjects(isRefresh: true),
                  child: const ProjectList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PalleteColor.backgroundColor,
        foregroundColor: PalleteColor.white,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(
            context,
          ).push(PageTransition.navigateTo(const ProjectCreateAndUpdatePage()));
        },
        child: const Icon(Icons.add_sharp),
      ),
    );
  }
}
