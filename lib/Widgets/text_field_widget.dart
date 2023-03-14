import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String Function(String? v)? validator;
  final bool? enabled;
  void Function(String)? onSubmitted;
  void Function()? onEditingComplete;

  TextFieldWidget(
      {@required this.title,
      @required this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.enabled = true,
      this.onChanged,
      this.onSubmitted,
      this.onEditingComplete});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        autofocus: false,
        enabled: widget.enabled,
        obscureText: widget.obscureText!,
        keyboardType: widget.keyboardType,
        controller: widget.controller!,
        validator: widget.validator!,
        focusNode: FocusNode(),
        decoration: InputDecoration(
          labelText: widget.title,
          border: OutlineInputBorder(),
        ),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
