import 'package:flutter/material.dart';

class HeartToggleWidget extends StatefulWidget {
  @override
  _HeartToggleWidgetState createState() => _HeartToggleWidgetState();
}

class _HeartToggleWidgetState extends State<HeartToggleWidget> {
  bool _isHeartFilled = false;

  void _toggleHeart() {
    setState(() {
      _isHeartFilled = !_isHeartFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background image
      

        // Circular container
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(166, 21, 183, 162),
          ),
          child: Center(
            child: GestureDetector(
              onTap: _toggleHeart,
              child: Icon(
                _isHeartFilled ? Icons.favorite : Icons.favorite_border,
                color: _isHeartFilled ? Colors.red : const Color.fromARGB(255, 255, 255, 255),
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
