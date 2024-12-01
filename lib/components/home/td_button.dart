import 'package:flutter/material.dart';

class TdButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const TdButton({
    super.key, 
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          )
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 190, 191, 192),
            fontSize: 22 ),
        ),
        
      ),
    );
  }
}
