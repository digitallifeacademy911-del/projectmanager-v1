import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/common/utils/page_transition.dart';
import 'package:projectmanager/model/project.dart';
import 'package:projectmanager/common/utils/string_utilities.dart';
import 'package:projectmanager/view/pages/authenticated/project_create_and_update_page.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        isHover = true;
      }),
      onExit: (event) => setState(() {
        isHover = false;
      }),
      child: GestureDetector(
        child: AnimatedContainer(
          width: double.infinity,
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: PalleteColor.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              !isHover
                  ? BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                    )
                  : BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      blurStyle: BlurStyle.outer,
                    ),
            ],
          ),
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceOut,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        widget.project.title[0],
                        style: AppFont.karla.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: PalleteColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringUtilities.truncate(widget.project.title, 7),
                          style: AppFont.karla.copyWith(
                            fontSize: AppConst.h2,
                            color: PalleteColor.foregroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IntrinsicWidth(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: widget.project.status.color.withValues(
                                alpha: 0.18,
                              ),
                              border: BoxBorder.all(
                                width: 1,
                                color: widget.project.status.color,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 5,
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: widget.project.status.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Text(
                                  widget.project.status.value,
                                  style: TextStyle(
                                    color: widget.project.status.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          StringUtilities.truncate(
                            widget.project.description,
                            12,
                          ),
                          style: AppFont.karla.copyWith(
                            fontSize: 16,
                            color: PalleteColor.foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicWidth(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          context.read<ProjectViewModel>().deleteProject(
                            widget.project.id!,
                          );
                        },
                        icon: Icon(Icons.delete_rounded, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            PageTransition.navigateTo(
              ProjectCreateAndUpdatePage(project: widget.project),
            ),
          );
        },
      ),
    );
  }
}
