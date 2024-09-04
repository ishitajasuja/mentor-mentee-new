import 'package:flutter/material.dart';

class BackArrowWidget extends StatelessWidget {
  final Widget destinationPage; // The page to navigate to

  BackArrowWidget({required this.destinationPage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background image (if needed, you can add an Image widget here)
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
         color: Color.fromARGB(166, 21, 183, 162),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to the destination page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destinationPage),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
