import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    this.controller,
    this.hText,
    this.lText,
    this.prefixIconName,
    this.suffixIconName,
    this.obscureText = false,
    this.keyboard,
  });

  final TextEditingController? controller;
  final String? hText;
  final String? lText;
  final IconData? prefixIconName;
  final IconButton? suffixIconName;
  final bool obscureText;
  final TextInputType? keyboard;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) return "Please Enter required data";
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIconName),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: suffixIconName,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45)),
        hintText: hText,
        focusColor: Colors.blue,
        labelText: lText,
      ),
    );
  }
}
