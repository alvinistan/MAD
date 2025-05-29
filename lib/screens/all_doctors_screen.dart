import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_detail_screen.dart';

class AllDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List of Doctors")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      data['image'] ?? 'assets/images/placeholder.png',
                    ),
                    radius: 30,
                  ),
                  title: Text(data['name'] ?? 'No Name'),
                  subtitle: Text(data['type'] ?? 'No Type'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("⭐ ${data['rating'] ?? '0.0'}"),
                      SizedBox(height: 4),
                      Text(data['date'] ?? '', style: TextStyle(fontSize: 10)),
                    ],
                  ),
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
