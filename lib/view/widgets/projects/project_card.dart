import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/model/project.dart';
import 'package:projectmanager/utils/string_utilities.dart';

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
      onEnter: (event) => setState(() {
        isHover = true;
      }),
      onExit: (event) => setState(() {
        isHover = false;
      }),
      child: AnimatedContainer(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(20),
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
                width: 70,
                height: 70,
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
                  children: [
                    Text(
                      StringUtilities.truncate(widget.project.title, 10),
                      style: AppFont.karla.copyWith(
                        fontSize: AppConst.h2,
                        color: PalleteColor.foregroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
