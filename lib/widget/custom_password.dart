import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class passwordtextfield extends StatefulWidget {
  const passwordtextfield(
      {super.key, required this.hint, this.onpassword, String? initialValue});

  final Function(String)? onpassword;
  final String hint;

  @override
  State<passwordtextfield> createState() => _passwordtextfieldState();
}

class _passwordtextfieldState extends State<passwordtextfield> {
  bool isTrue = true;

  void check() {
    setState(() {
      isTrue = !isTrue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return S.of(context).enterpassword;
        }
        return null;
      },
      onChanged: widget.onpassword,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      obscureText: isTrue,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 111, 111, 109)),
        labelText: widget.hint,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        suffixIcon: IconButton(
          onPressed: () {
            check();
          },
          icon: isTrue
              ? const Icon(
                  Icons.visibility_off,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              : const Icon(Icons.visibility,
                  color: Color.fromARGB(255, 0, 0, 0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );
  }
}
