import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatelessWidget {
  final String mentorName;
  final String mentorDomain;
  final DateTime selectedDate;
  final String selectedSlot;

  ReviewPage({
    required this.mentorName,
    required this.mentorDomain,
    required this.selectedDate,
    required this.selectedSlot,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Booking'),
        backgroundColor: Color.fromARGB(166, 21, 183, 162),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mentor Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Name: $mentorName',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Domain: $mentorDomain',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Booking Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${formatter.format(selectedDate)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Slot: $selectedSlot',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the payment page or perform booking confirmation
                  Navigator.pushNamed(context, '/payment');
                },
                child: Text('Confirm Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(166, 21, 183, 162), // Button color
                 foregroundColor: Colors.white, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
