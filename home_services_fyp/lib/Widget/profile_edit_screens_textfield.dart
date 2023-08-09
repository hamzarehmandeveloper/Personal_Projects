import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  int? maxLines;
  String? label;
  String? text;
  ValueChanged<String>? onChanged;
  final TextEditingController controller;

  TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController initTextController;

  @override
  void initState() {
    super.initState();
    initTextController = TextEditingController(text: widget.text);
  }


  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xfff1f1f5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: initTextController.text,
                hintStyle: TextStyle(
                  color: Colors.black
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              maxLines: widget.maxLines,
            ),
          ),
        ],
      );
}
