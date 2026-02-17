import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/model/project.dart';
import 'package:projectmanager/view/widgets/projects/form/project_form.dart';
import 'package:projectmanager/viewmodel/Authentication/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectCreateAndUpdatePage extends StatefulWidget {
  const ProjectCreateAndUpdatePage({super.key});

  @override
  State<ProjectCreateAndUpdatePage> createState() =>
      _ProjectCreateAndUpdatePageState();
}

class _ProjectCreateAndUpdatePageState
    extends State<ProjectCreateAndUpdatePage> {
  @override
  Widget build(BuildContext context) {
    Project? project = ModalRoute.of(context)?.settings.arguments as Project?;

    return Consumer<AuthViewmodel>(
      builder: (BuildContext context, AuthViewmodel viewmodel, Widget? child) {
        return Scaffold(
          backgroundColor: PalleteColor.backgroundColor,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 50,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  (project == null) ? 'New Project' : project.title,
                  style: AppFont.karla.copyWith(
                    color: PalleteColor.white,
                    fontSize: AppConst.h2,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
                    decoration: BoxDecoration(
                      color: PalleteColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: AppConst.bodyRadius,
                        topRight: AppConst.bodyRadius,
                      ),
                    ),
                    child: ProjectForm(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
