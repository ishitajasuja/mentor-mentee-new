import 'package:flutter/material.dart';

// Define the MentorWidget
class MentorWidget extends StatelessWidget {
  final String imageUrl;
  final String mentorName;
  final double rating; // Rating between 0 and 5
  final String domain1;
  final String domain2;
  final String domain3;
  final VoidCallback onTap; // Callback for tap action

  MentorWidget({
    required this.imageUrl,
    required this.mentorName,
    required this.rating,
    required this.domain1,
    required this.domain2,
    required this.domain3,
    required this.onTap, // Initialize callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the callback on tap
      child: Container(
        width: 180,
        height: 210,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 30.0,
                ),
                SizedBox(height: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        mentorName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 16.0, // Reduced star size
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  domain1,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(166, 21, 183, 162),
                  ),
                ),
                Text(
                  domain2,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 69, 198, 181),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  domain3,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 69, 198, 181),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
