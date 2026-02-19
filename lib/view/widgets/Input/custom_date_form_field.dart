import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';

class CustomDateFormField extends StatelessWidget {
  final String hintText;
  final DateTime? initialDate;
  final Function(DateTime?)? onDateSelected;
  final IconData? icon;
  final bool dateAndTime;

  const CustomDateFormField({
    super.key,
    required this.hintText,
    required this.onDateSelected,
    this.initialDate,
    this.icon = Icons.event_note,
    this.dateAndTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        counterStyle: TextStyle(color: PalleteColor.foregroundColor),
        filled: true,
        fillColor: PalleteColor.inputBackgroundColor,
        enabledBorder: AppConst.inputBorder,
        focusedBorder: AppConst.inputClickedBorder,
        hintText: hintText,
        hintStyle: AppFont.karla.copyWith(
          fontSize: AppConst.p,
          color: PalleteColor.whiteWeak,
        ),
        suffixIcon: Icon(icon, color: PalleteColor.whiteWeak),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
      style: AppFont.karla.copyWith(
        color: PalleteColor.foregroundColor,
        fontSize: AppConst.p,
      ),
      mode: dateAndTime
          ? DateTimeFieldPickerMode.dateAndTime
          : DateTimeFieldPickerMode.date,
      dateFormat: DateFormat('EEE, MMM d, yyyy'),
      initialValue: initialDate,
      onChanged: onDateSelected,
    );
  }
}
