import 'package:flutter/material.dart';


class InputField extends StatefulWidget {
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
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late final TextEditingController controller;

  void initState() {
    super.initState();
    //controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff1f1f5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:Color(0xff94959b),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.suffixIcon,
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
