import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.isObscured,
    this.textInputAction,
    this.focusNode,
    required this.textInputType,
    this.validator,
    this.onSaved,
    this.onEditingComplete,
    required this.autovalidateMode,
    required this.hidePassword,
    this.onVisibilityTaped,
    this.maxLines = 1,
    this.controller,
    this.initialValue,
  });
  final String hintText;
  final bool isObscured;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final AutovalidateMode autovalidateMode;
  final bool hidePassword;
  final void Function()? onVisibilityTaped;
  final int maxLines;
  final TextEditingController? controller;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      focusNode: focusNode,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      obscureText: hidePassword,
      onEditingComplete: onEditingComplete,
      style: const TextStyle().copyWith(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: const TextStyle().copyWith(
          color: Colors.white,
          fontSize: 18,
        ),
        suffixIcon: isObscured
            ? IconButton(
                onPressed: onVisibilityTaped,
                icon: hidePassword
                    ? const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      ),
              )
            : null,
      ),
      cursorColor: Colors.blue,
    );
  }
}
