import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Make sure this screen exists and accepts doctorId, userId

class MessagesScreen extends StatelessWidget {
  final String userId;

  const MessagesScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text("Messages"), backgroundColor: Colors.teal),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doc = doctors[index];
              final doctorId = doc.id;
              final chatId = '${doctorId}_$userId';

              return StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatId)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .limit(1)
                        .snapshots(),
                builder: (context, chatSnapshot) {
                  if (!chatSnapshot.hasData ||
                      chatSnapshot.data!.docs.isEmpty) {
                    return SizedBox.shrink(); // Skip if no messages
                  }

                  final lastMsg = chatSnapshot.data!.docs.first;

                  return ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(doc['image'] ?? ''),
                    ),
                    title: Text(
                      doc['name'] ?? 'Doctor',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(lastMsg['text'] ?? ''),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTimestamp(lastMsg['timestamp']),
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ChatScreen(
                                doctorId: doctorId,
                                userId: userId,
                              ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final dt = timestamp.toDate();
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} $ampm';
  }
}
