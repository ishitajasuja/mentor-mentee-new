import 'package:flutter/material.dart';

// Define the SearchBar widget
class SearchBarr extends StatelessWidget {
  final String hintText;
  final IconData startIcon;
  final IconData endIcon;
  final void Function()? onEndIconPressed;

  SearchBarr({
    required this.hintText,
    this.startIcon = Icons.search,
    this.endIcon = Icons.mic,
    this.onEndIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(startIcon, color: Colors.grey),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(endIcon, color: Colors.grey),
            onPressed: onEndIconPressed,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        ),
      ),
    );
  }
}
