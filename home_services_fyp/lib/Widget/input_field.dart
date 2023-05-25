import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController controller;

  const InputField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff1f1f5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:Color(0xff94959b),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffixIcon,
        ),
        validator: (input) =>
        input == null
            ? 'Please enter a valid Data'
            : null,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
