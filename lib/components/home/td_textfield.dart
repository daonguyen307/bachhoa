import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TdTextField extends StatelessWidget {
  final Icon icon;
  final String label;
  TextEditingController controller;
  bool secureText;
  TdTextField(
      {super.key,
      required this.icon,
      required this.label,
      required this.controller,
      this.secureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: secureText,
      style: const TextStyle(color: Colors.black, fontFamily: 'SFUIDisplay'),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        prefixIcon: icon,
        labelStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
