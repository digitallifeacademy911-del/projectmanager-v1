import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/const/enum/project_statut.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/common/utils/messenger.dart';
import 'package:projectmanager/model/project.dart';
import 'package:projectmanager/view/widgets/Input/custom_date_form_field.dart';
import 'package:projectmanager/view/widgets/Input/custom_text_form_field.dart';
import 'package:projectmanager/viewmodel/Authentication/auth_viewmodel.dart';
import 'package:projectmanager/viewmodel/project/project_viewmodel.dart';
import 'package:provider/provider.dart';

class ProjectCreateAndUpdatePage extends StatefulWidget {
  final Project? project;

  const ProjectCreateAndUpdatePage({super.key, this.project});

  @override
  State<ProjectCreateAndUpdatePage> createState() =>
      _ProjectCreateAndUpdatePageState();
}

class _ProjectCreateAndUpdatePageState
    extends State<ProjectCreateAndUpdatePage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late ProjectStatut _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _titleController = TextEditingController(text: p?.title ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _selectedStatus = p?.status ?? ProjectStatut.notStarted;
    _startDate = p?.startdate;
    _endDate = p?.enddate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;
    final isLoading = context.watch<ProjectViewModel>().isLoading;

    return Scaffold(
      backgroundColor: PalleteColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: PalleteColor.backgroundColor,
        foregroundColor: PalleteColor.white,
        centerTitle: true,
        actions: [
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
        ],
        title: Text(
          isEditing ? widget.project!.title : 'New Project',
          style: AppFont.karla.copyWith(
            color: PalleteColor.white,
            fontSize: AppConst.h2,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: AbsorbPointer(
        absorbing: isLoading,
        child: Opacity(
          opacity: isLoading ? 0.6 : 1.0,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 20,
            ), // Remplacer le spacing de Column si besoin
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
            decoration: BoxDecoration(
              color: PalleteColor.white,
              borderRadius: BorderRadius.vertical(top: AppConst.bodyRadius),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "Project Title",
                      controller: _titleController,
                    ),
                    const SizedBox(height: 20),
                    _buildDescriptionField(),
                    const SizedBox(height: 20),
                    CustomDateFormField(
                      initialDate: _startDate,
                      hintText: 'Start Date',
                      onDateSelected: (date) =>
                          setState(() => _startDate = date),
                    ),
                    const SizedBox(height: 20),
                    CustomDateFormField(
                      initialDate: _endDate,
                      hintText: 'End Date',
                      onDateSelected: (date) => setState(() => _endDate = date),
                    ),
                    const Divider(height: 40),
                    _buildStatusSelector(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading
            ? null
            : _onSave, // Désactive le bouton si chargement
        backgroundColor: isLoading ? Colors.grey : PalleteColor.backgroundColor,
        shape: CircleBorder(),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Icon(
                isEditing ? Icons.edit : Icons.add_sharp,
                color: PalleteColor.white,
              ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return SizedBox(
      height: 150,
      child: TextField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Your project description',
          filled: true,
          fillColor: PalleteColor.inputBackgroundColor,
          enabledBorder: AppConst.inputBorder,
          focusedBorder: AppConst.inputClickedBorder,
          hintStyle: AppFont.karla.copyWith(
            fontSize: AppConst.p,
            color: PalleteColor.whiteWeak,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      children: ProjectStatut.values.where((status) => status.isSelectable).map(
        (status) {
          return RadioListTile<ProjectStatut>(
            title: Text(status.name.toUpperCase()),
            value: status,
            groupValue: _selectedStatus,
            activeColor: status.color,
            onChanged: (val) => setState(() => _selectedStatus = val!),
          );
        },
      ).toList(),
    );
  }

  void _onSave() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a project title")),
      );
      return;
    }

    // 1. CAPTURE immédiate des références avant tout 'await'
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final viewModel = Provider.of<ProjectViewModel>(context, listen: false);
    final authViewModel = Provider.of<AuthViewmodel>(context, listen: false);

    // 2. Opérations asynchrones
    final user = await authViewModel.getCurrentUser();

    final updatedProject = Project(
      id: widget.project?.id,
      title: title,
      description: _descriptionController.text.trim(),
      status: _selectedStatus,
      startdate: _startDate,
      enddate: _endDate,
      user: user,
    );

    bool success;
    if (widget.project == null) {
      success = await viewModel.createProject(updatedProject);
    } else {
      success = await viewModel.updateProject(updatedProject);
    }

    // 3. Vérification de sécurité
    if (!mounted) return;

    if (success) {
      // Utilisation de la référence capturée 'messenger' au lieu de repasser le 'context'
      // Il faut modifier ta classe Messenger pour accepter ScaffoldMessengerState
      // OU simplement appeler la bannière ici :
      messenger.clearMaterialBanners();
      Messenger.showSuccess(
        context,
        Text(widget.project == null ? "Project created!" : "Project updated!"),
      );

      // Fermeture de la page via la référence capturée
      navigator.pop();
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage ?? "An error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
