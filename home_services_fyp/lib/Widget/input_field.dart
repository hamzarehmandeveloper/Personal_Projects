import 'package:flutter/material.dart';


class InputField extends StatefulWidget {
  final String? hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? textFieldValidator;

  const InputField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.suffixIcon,
    required this.controller,
    this.textFieldValidator,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late final TextEditingController controller;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.textFieldValidator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color:Color(0xff94959b),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: widget.suffixIcon,
      ),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
    );
  }
}
