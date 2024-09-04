import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class MentorCalendarPage extends StatefulWidget {
  final String mentorId;

  MentorCalendarPage({required this.mentorId});

  @override
  _MentorCalendarPageState createState() => _MentorCalendarPageState();
}

class _MentorCalendarPageState extends State<MentorCalendarPage> {
  final String apiUrl = 'http://10.0.2.2:5001'; // Ensure this URL is correct
  Map<DateTime, List<String>> availability = {};
  List<String> selectedSlots = [];
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fetchDates();
  }

  Future<void> fetchDates() async {
    final response = await http
        .get(Uri.parse('$apiUrl/get_dates?mentor_id=${widget.mentorId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        availability = data.map<DateTime, List<String>>(
          (key, value) {
            return MapEntry(
              DateTime.parse(key),
              (value as List<dynamic>).map((item) => item as String).toList(),
            );
          },
        );
      });
    }
  }

  Future<void> fetchSlots(DateTime date) async {
    final response = await http.get(Uri.parse(
        '$apiUrl/get_slots?mentor_id=${widget.mentorId}&date=${date.toIso8601String()}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        availability[date] =
            List<String>.from(data.map((item) => item as String));
      });
    } else {
      setState(() {
        availability[date] = [];
      });
    }
  }

  Future<void> updateDate(DateTime date, List<String> slots) async {
    final response = await http.post(
      Uri.parse('$apiUrl/update_date'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mentor_id': widget.mentorId,
        'date': date.toIso8601String(),
        'status': 'available',
        'slots': slots
      }),
    );

    if (response.statusCode == 200) {
      fetchDates();
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final List<String> allSlots = List.generate(10, (index) {
      final hour = index + 8;
      final hourStr = hour < 10 ? '0$hour' : '$hour';
      return '$hourStr:00 - ${hourStr}:59';
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
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
                    color: Color.fromARGB(166, 21, 183, 162).withOpacity(0.3),
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
            ),
          ),
          if (selectedDate != null)
            Expanded(
              child: ListView(
                children: allSlots.map((slot) {
                  return CheckboxListTile(
                    title: Text(slot),
                    value: selectedSlots.contains(slot),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedSlots.add(slot);
                        } else {
                          selectedSlots.remove(slot);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (selectedDate != null) {
                updateDate(selectedDate!, selectedSlots);
              }
            },
            child: Text('Update Date'),
          ),
        ],
      ),
    );
  }
}
