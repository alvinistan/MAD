// doctor_detail_screen.dart
import 'package:flutter/material.dart';
import 'book_appointment_screen.dart';
import 'chat_screen.dart'; // Add this import

class DoctorDetailScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailScreen({required this.doctor});

  @override
  Widget build(BuildContext context) {
    List<String> times = List<String>.from(doctor['workingHours'] ?? []);
    List<String> dates = List<String>.from(doctor['availableDates'] ?? []);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("Appointment")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      doctor['image'] != null &&
                              doctor['image'].toString().isNotEmpty
                          ? NetworkImage(doctor['image'])
                          : AssetImage('assets/images/dr_Mary.png')
                              as ImageProvider,
                  radius: 40,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'] ?? 'Doctor Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor['type'] ?? 'Specialist',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chat, color: Colors.teal),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ChatScreen(
                                  doctorId: doctor['id'] ?? 'dr123',
                                  userId:
                                      'user456', // Replace with actual FirebaseAuth user ID
                                ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.call, color: Colors.teal),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("📞 Calling the doctor...")),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoBox("Patients", doctor['patients'] ?? '0'),
                _infoBox("Experience", doctor['experience'] ?? 'N/A'),
                _infoBox("Reviews", doctor['reviews'] ?? '0'),
              ],
            ),

            SizedBox(height: 20),

            Text(
              "Biography",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              doctor['bio'] ?? 'No biography available.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            SizedBox(height: 20),

            Text(
              "Working Hours",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children:
                  times.map((t) {
                    return Chip(
                      backgroundColor: Colors.teal[50],
                      label: Text(t),
                    );
                  }).toList(),
            ),

            SizedBox(height: 20),

            Text(
              "Schedule",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  dates.map((day) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            day,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(" ", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  }).toList(),
            ),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookAppointmentScreen(doctor: doctor),
                  ),
                );
              },
              icon: Icon(Icons.calendar_month),
              label: Text("Book an Appointment"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
