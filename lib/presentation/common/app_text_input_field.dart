import 'package:cost_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextInputField extends StatelessWidget {
  const AppTextInputField({
    Key? key,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorder,
    this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final IconButton? suffixIcon;
  final IconButton? prefixIcon;
  final InputBorder? enabledBorder;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffix: suffixIcon,
        enabledBorder: enabledBorder,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.colorDark25,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
