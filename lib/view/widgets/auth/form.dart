import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/view/widgets/Input/custom_password_form_field.dart';
import 'package:projectmanager/view/widgets/Input/custom_text_form_field.dart';
import 'package:projectmanager/view/widgets/button/form_submit.dart';

class AuthForm extends StatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final String submitText;
  final VoidCallback? onSubmit;
  const AuthForm({
    super.key,
    required this.submitText,
    this.onSubmit,
    this.emailController,
    this.passwordController,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        spacing: 20,
        children: [
          CustomTextFormField(
            hintText: 'emailController',
            icon: Icon(Icons.mail_outline),
            controller: widget.emailController,
          ),
          CustomPasswordFormField(
            hintText: 'Password',
            controller: widget.passwordController,
          ),

          FormSubmit(
            onPressed: widget.onSubmit,
            child: Text(
              widget.submitText,
              style: AppFont.karla.copyWith(
                fontSize: AppConst.p,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
