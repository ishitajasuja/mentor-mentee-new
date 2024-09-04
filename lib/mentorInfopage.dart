import 'package:flutter/material.dart';
import 'package:mentormentee/HomePage.dart';
import 'package:mentormentee/menteecalendar.dart';
import 'package:mentormentee/mentorcalendar.dart';
import 'package:mentormentee/widgets/HeartToggle.dart';
import 'package:mentormentee/widgets/backarrow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MentorPage extends StatelessWidget {
  final String imageUrl;
  final String mentorName;
  final double rating; // Rating between 0 and 5
  final String domain1;
  final String domain2;
  final String domain3;
  final String description;
  final double pricing; // Price per session
  final int numReviews; // Number of reviews

  MentorPage({
    required this.imageUrl,
    required this.mentorName,
    required this.rating,
    required this.domain1,
    required this.domain2,
    required this.domain3,
    required this.description,
    required this.pricing,
    required this.numReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackArrowWidget(destinationPage: HomePage()),
                Spacer(),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 600,
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                                radius: 100.0,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                mentorName,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(166, 21, 183, 162),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow,
                                        size: 22.0,
                                      );
                                    }),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '$numReviews Reviews',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDomainText(domain1),
                                  _buildDomainText(domain2),
                                  _buildDomainText(domain3),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Pricing: \$${pricing.toStringAsFixed(2)} per session',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(166, 21, 183, 162),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookingPage(
                                                mentorId:
                                                    '1')), // Pass mentor ID 1
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(166, 21, 183, 162),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text('View Calendar'),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10.0,
                          right: 10.0,
                          child: HeartToggleWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainText(String domain) {
    return Text(
      domain,
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(166, 21, 183, 162),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
