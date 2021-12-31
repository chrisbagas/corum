import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onSaved;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.text,
    required this.onSaved,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(59, 148, 94, 1.0),
                  )),
            ),
          ),
        ],
      );
}
