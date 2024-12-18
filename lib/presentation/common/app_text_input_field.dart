import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:flutter/material.dart';

class AppTextInputField extends StatefulWidget {
  const AppTextInputField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.isPasswordField = false,
    this.validator,
    this.stream,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final String? hintText;
  final bool isPasswordField;
  final String? Function(String)? validator;
  final Stream<String>? stream; // Stream là optional

  @override
  State<AppTextInputField> createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  bool _isPasswordVisible = false;
  String _currentValue = ''; // Dùng khi không có stream

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.stream, // Có thể là null
      builder: (context, snapshot) {
        // Ưu tiên giá trị từ stream nếu có, nếu không sử dụng controller hoặc state nội bộ
        final value = snapshot.data ?? widget.controller?.text ?? _currentValue;
        final errorText = widget.validator?.call(value);

        return TextField(
          controller: widget.controller,
          obscureText: widget.isPasswordField && !_isPasswordVisible,
          onChanged: (newValue) {
            if (widget.onChanged != null) widget.onChanged!(newValue);
            if (widget.stream == null) {
              setState(() {
                _currentValue = newValue;
              });
            }
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                AppTextStyles.body1.copyWith(color: AppColors.colorDark25),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
