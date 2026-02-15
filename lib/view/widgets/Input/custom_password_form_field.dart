import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';

class CustomPasswordFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  const CustomPasswordFormField({super.key, this.controller, this.hintText});

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      obscuringCharacter: '*',
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: PalleteColor.inputBackgroundColor,
        enabledBorder: AppConst.inputBorder,
        focusedBorder: AppConst.inputClickedBorder,
        hintStyle: AppFont.karla.copyWith(
          fontSize: AppConst.p,
          color: PalleteColor.whiteWeak,
        ),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            isObscured = !isObscured;
          }),
          icon: Icon(
            isObscured
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}
