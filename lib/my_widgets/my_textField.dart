import 'package:flutter/material.dart';

class MyTextFilde extends StatefulWidget {
  static bool sil = false;
  final String txt;
  final Function(String) onChanged;
  final bool isPassword;
  TextEditingController controller;
  MyTextFilde(
      {required this.txt,
      required this.onChanged,
      required this.isPassword,
      required this.controller});

  @override
  State<MyTextFilde> createState() => _MyTextFildeState();
}

class _MyTextFildeState extends State<MyTextFilde> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (MyTextFilde.sil == true) {
      controller.clear();
    }
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      controller: controller,
      keyboardType: !widget.isPassword ? TextInputType.number : null,
      obscureText: widget.isPassword,
      //textAlign: TextAlign.center,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: widget.txt,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo[700]!, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 3),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
