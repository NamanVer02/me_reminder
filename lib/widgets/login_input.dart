import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({super.key, required this.hint, this.suffix, this.prefix, required this.getText, required this.visibility});

  final hint;
  final suffix;
  final prefix;
  final visibility;

  final void Function(String text) getText;

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        widget.getText(value);
      },
      obscureText: (widget.visibility) ? false : true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 15,
          fontWeight: FontWeight.w400
        ),
        hintText: widget.hint,
        fillColor: Colors.grey[200],
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
      ),
    );
  }
}
