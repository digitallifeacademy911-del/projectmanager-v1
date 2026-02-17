import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/view/widgets/projects/project_list.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectViewModel>(
      
      builder:
          (BuildContext context, ProjectViewModel viewmodel, Widget? child) {
            return Scaffold(
              backgroundColor: PalleteColor.backgroundColor,
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 50,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Project',
                      style: AppFont.karla.copyWith(
                        color: PalleteColor.white,
                        fontSize: AppConst.h2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 50,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: PalleteColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: AppConst.bodyRadius,
                            topRight: AppConst.bodyRadius,
                          ),
                        ),
                        child: ProjectList(),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(onPressed: () {}, child: Container(width: ,decoration: BoxDecoration(color: PalleteColor.backgroundColor, shape: BoxShape.circle),),),
            );
          },
    );
  }
}
