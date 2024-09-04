import 'package:flutter/material.dart';

// Define the Tag widget
class Tag extends StatelessWidget {
  final String text;

  Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 146, 212, 203), // Background color
        borderRadius: BorderRadius.circular(20.0), // Oval shape
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black, // Text color
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
