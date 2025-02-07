import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.button, this.click});
  final button;
  final VoidCallback? click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: Text(
          button,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            // fontFamily: 'Pacifico-Regular'),
          ),
        )),
      ),
    );
  }
}
