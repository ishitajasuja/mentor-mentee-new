import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentormentee/PaymentPage.dart';
import 'package:mentormentee/ReviewPage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final String mentorId;

  BookingPage({required this.mentorId});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final String apiUrl = 'http://10.0.2.2:5000';
  Map<DateTime, List<String>> availability = {};
  DateTime? selectedDate;
  String? selectedSlot;
  Map<String, dynamic>? selectedMentor;

  @override
  void initState() {
    super.initState();
    fetchDates();
    fetchMentors();
  }

  Future<void> fetchDates() async {
    final response = await http
        .get(Uri.parse('$apiUrl/get_dates?mentor_id=${widget.mentorId}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        availability = data.map<DateTime, List<String>>(
          (key, value) =>
              MapEntry(DateTime.parse(key), List<String>.from(value)),
        );
      });
    } else {
      setState(() {
        availability = {};
      });
    }
  }

  Future<void> fetchMentors() async {
    final response = await http.get(Uri.parse('$apiUrl/mentors'));

    if (response.statusCode == 200) {
      final mentors = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        selectedMentor = mentors.isNotEmpty ? mentors[0] : null;
      });
    } else {
      print('Failed to fetch mentors');
    }
  }

  Future<void> fetchSlots(DateTime date) async {
    final response = await http.get(Uri.parse(
        '$apiUrl/get_slots?mentor_id=${widget.mentorId}&date=${date.toIso8601String()}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        availability[date] = List<String>.from(data);
      });
    } else {
      setState(() {
        availability[date] = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Session'),
        backgroundColor: Color.fromARGB(166, 21, 183, 162),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Steps Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BookingStep(
                  icon: Icons.schedule,
                  title: 'Schedule Session',
                  onTap: () {},
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  width: 20,
                ),
                BookingStep(
                  icon: Icons.rate_review,
                  title: 'Review Session',
                  onTap: () {
                    
                  },
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  width: 20,
                ),
                BookingStep(
                  icon: Icons.payment,
                  title: 'Payment',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(height: 20),
            // Calendar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: Color.fromARGB(166, 21, 183, 162), width: 2.0),
              ),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(2020),
                lastDay: DateTime(2100),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    fetchSlots(selectedDay);
                  });
                },
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(166, 21, 183, 162),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(166, 21, 183, 162).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  markerBuilder: (context, date, events) {
                    if (availability[date] != null &&
                        availability[date]!.isNotEmpty) {
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Slots for Selected Date
            if (selectedDate != null && availability[selectedDate] != null) ...[
              Text(
                'Available Slots for ${formatter.format(selectedDate!)}:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...(availability[selectedDate!] ?? []).map((slot) {
                return ListTile(
                  title: Text(slot),
                  tileColor: selectedSlot == slot
                      ? Colors.green.withOpacity(0.2)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedSlot = slot;
                    });
                  },
                );
              }).toList(),
              SizedBox(height: 20),
              // Next Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedSlot != null && selectedMentor != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewPage(
                            mentorName:
                                selectedMentor!['name'] ?? 'Mentor Name',
                            mentorDomain:
                                selectedMentor!['domain1'] ?? 'Mentor Domain',
                            selectedDate: selectedDate!,
                            selectedSlot: selectedSlot!,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a slot')),
                      );
                    }
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(166, 21, 183, 162),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class BookingStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  BookingStep({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Color.fromARGB(166, 21, 183, 162),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(166, 21, 183, 162),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
