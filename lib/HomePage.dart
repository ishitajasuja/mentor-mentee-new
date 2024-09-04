import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:mentormentee/mentorInfopage.dart';
import 'package:mentormentee/widgets/MentorWidget.dart';
import 'package:mentormentee/widgets/SearchBar.dart';
import 'package:mentormentee/widgets/Tags.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> mentors = [];

  @override
  void initState() {
    super.initState();
    fetchMentors();
  }

  Future<void> fetchMentors() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/mentors'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          mentors = data.map((item) {
            final mentor = item as Map<String, dynamic>;
            return {
              'imageUrl': mentor['imageUrl'] ?? 'default_image_url.png',
              'name': mentor['name'] ?? 'Unknown',
              'rating': (mentor['rating'] is String)
                  ? double.tryParse(mentor['rating']) ?? 0.0
                  : mentor['rating']?.toDouble() ?? 0.0,
              'domain1': mentor['domain1'] ?? 'N/A',
              'domain2': mentor['domain2'] ?? 'N/A',
              'domain3': mentor['domain3'] ?? 'N/A',
              'description': mentor['description'] ?? 'No description',
              'pricing': mentor['pricing'] ?? 'No pricing',
              'numReviews': (mentor['numReviews'] as int?) ?? 0,
            };
          }).toList();
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/image (1).png"),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Welcome ",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Lato',
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Parth ",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Lato',
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 110),
                  Image.asset("assets/Vector.png"),
                ],
              ),
              SizedBox(height: 40),
              SearchBarr(
                hintText: "Search for Mentors",
                startIcon: Icons.search,
                endIcon: Icons.mic,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Tags",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Lato',
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tag(text: "AI"),
                  Tag(text: "Web Development"),
                  Tag(text: "Blockchain"),
                  Tag(text: "App"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended Tutors",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato',
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "See More >> ",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Lato',
                        color: Color.fromARGB(166, 21, 183, 162),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 20),
              mentors.isEmpty
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: mentors.length,
                      itemBuilder: (context, index) {
                        final mentor = mentors[index];
                        return MentorWidget(
                          imageUrl:
                              mentor['imageUrl'] ?? 'default_image_url.png',
                          mentorName: mentor['name'] ?? 'Unknown',
                          rating: mentor['rating'] ?? 0.0,
                          domain1: mentor['domain1'] ?? 'N/A',
                          domain2: mentor['domain2'] ?? 'N/A',
                          domain3: mentor['domain3'] ?? 'N/A',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MentorPage(
                                  imageUrl: mentor['imageUrl'] ??
                                      'default_image_url.png',
                                  mentorName: mentor['name'] ?? 'Unknown',
                                  rating: mentor['rating'] ?? 0.0,
                                  domain1: mentor['domain1'] ?? 'N/A',
                                  domain2: mentor['domain2'] ?? 'N/A',
                                  domain3: mentor['domain3'] ?? 'N/A',
                                  description:
                                      mentor['description'] ?? 'No description',
                                  pricing: mentor['pricing'] ?? 'No pricing',
                                  numReviews:
                                      (mentor['numReviews'] as int?) ?? 0,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
