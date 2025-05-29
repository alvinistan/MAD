import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDoctorsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr Joseph",
      "type": "Kidney Specialist",
      "date": "10 Feb 2025 at 1.00 am",
      "rating": 4.5,
      "image": "assets/dr_joseph.png",
    },
    {
      "name": "Dr Mary",
      "type": "Heart Specialist",
      "date": "12 Feb 2025 at 11.00 am",
      "rating": 4.7,
      "image": "assets/dr_mary.png",
    },
    {
      "name": "Dr Juli",
      "type": "Neurologist",
      "date": "15 Feb 2025 at 2.30 pm",
      "rating": 4.6,
      "image": "assets/dr_juli.png",
    },
    {
      "name": "Dr John",
      "type": "Eye Specialist",
      "date": "17 Feb 2025 at 9.30 am",
      "rating": 4.8,
      "image": "assets/dr_john.png",
    },
    {
      "name": "Dr Emily",
      "type": "Psychologist",
      "date": "18 Feb 2025 at 1.30 pm",
      "rating": 4.9,
      "image": "assets/dr_emily.png",
    },
    {
      "name": "Dr Kevin",
      "type": "Therapist",
      "date": "20 Feb 2025 at 11.00 am",
      "rating": 4.3,
      "image": "assets/dr_kevin.png",
    },
    {
      "name": "Dr Sara",
      "type": "Dental Surgeon",
      "date": "22 Feb 2025 at 10.00 am",
      "rating": 4.4,
      "image": "assets/dr_sara.png",
    },
    {
      "name": "Dr Alex",
      "type": "Skin Specialist",
      "date": "24 Feb 2025 at 3.00 pm",
      "rating": 4.7,
      "image": "assets/dr_alex.png",
    },
    {
      "name": "Dr Hana",
      "type": "Child Specialist",
      "date": "25 Feb 2025 at 12.00 pm",
      "rating": 4.6,
      "image": "assets/dr_hana.png",
    },
    {
      "name": "Dr Liam",
      "type": "General Physician",
      "date": "26 Feb 2025 at 9.00 am",
      "rating": 4.5,
      "image": "assets/dr_liam.png",
    },
  ];

  void uploadDoctors(BuildContext context) async {
    final firestore = FirebaseFirestore.instance;

    for (var doc in doctors) {
      await firestore.collection('Doctors').add(doc);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ 10 Doctors Uploaded")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Doctors")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => uploadDoctors(context),
          child: Text("Upload 10 Doctors to Firestore"),
        ),
      ),
    );
  }
}
