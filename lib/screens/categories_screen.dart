// categories_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Dentist',
    'Cardiologist',
    'Psychologist',
    'Physiotherapist',
    'General Surgeon',
    'Therapist',
    'Pediatrician',
    'Neurologist',
    'Orthopedic',
    'Gynecologist',
    'Dermatologist',
    'Ophthalmologist',
    'ENT Specialist',
    'General Practitioner',
    'Urologist',
    'Endocrinologist',
    'Oncologist',
    'Gastroenterologist',
    'Pulmonologist',
    'Rheumatologist',
    'Hematologist',
    'Nephrologist',
    'Allergist',
    'Immunologist',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Categories")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "All Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...categories.map(
            (cat) => ListTile(
              leading: Icon(Icons.local_hospital, color: Colors.teal),
              title: Text(cat),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryDoctorsScreen(category: cat),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryDoctorsScreen extends StatelessWidget {
  final String category;
  CategoryDoctorsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category Doctors")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var docs =
              snapshot.data!.docs.where((doc) {
                final type = (doc['type'] ?? '').toString().toLowerCase();
                return type.contains(category.toLowerCase());
              }).toList();

          if (docs.isEmpty) {
            return Center(child: Text("No $category doctors found."));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        data['image'] != null &&
                                data['image'].toString().isNotEmpty
                            ? NetworkImage(data['image'])
                            : AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                    radius: 30,
                  ),
                  title: Text(data['name'] ?? 'Doctor Name'),
                  subtitle: Text(data['type'] ?? 'Specialist'),
                  trailing: Text("⭐ ${data['rating'] ?? '0.0'}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorDetailScreen(doctor: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
