import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class Emailtextfield extends StatelessWidget {
  const Emailtextfield(
      {required this.hint, this.onEmail, String? initialValue});
  final String hint;
  final Function(String)? onEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return S.of(context).enteremail;
        }
      },
      onChanged: onEmail,
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 107, 107, 105)),
        labelText: hint,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
