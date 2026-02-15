import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Icon? icon;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.icon,
    this.hintText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        suffixIcon: widget.icon,
      ),
    );
  }
}
