import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const BookAppointmentScreen({required this.doctor, Key? key})
    : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  String? selectedDistrict;
  String? selectedHospital;

  final List<String> districts = [
    "Jaffna",
    "Colombo",
    "Kandy",
    "Galle",
    "Trincomalee",
    "Batticaloa",
    "Kurunegala",
    "Anuradhapura",
    "Nuwara Eliya",
    "Badulla",
    "Matara",
    "Vavuniya",
    "Mannar",
    "Kilinochchi",
    "Mullaitivu",
    "Puttalam",
    "Monaragala",
    "Hambantota",
    "Polonnaruwa",
    "Matale",
    "Ampara",
    "Ratnapura",
    "Kegalle",
    "Gampaha",
    "Kalutara",
  ];

  final List<String> hospitals = [
    "General Hospital Colombo",
    "Mother Care Jaffna",
    "Nothern Hospital Jaffna",
    "City Hospital",
    "MediCare Hospital",
  ];

  final double bookingFee = 250;

  void bookNow() async {
    if (_formKey.currentState!.validate()) {
      final doctorFee = widget.doctor['fee'] ?? 3500;

      final appointment = {
        'doctorName': widget.doctor['name'],
        'doctorType': widget.doctor['type'],
        'userFirstName': firstNameCtrl.text,
        'userLastName': lastNameCtrl.text,
        'emailOrPhone': emailCtrl.text,
        'district': selectedDistrict,
        'hospital': selectedHospital,
        'doctorFee': doctorFee,
        'bookingFee': bookingFee,
        'total': doctorFee + bookingFee,
        'timestamp': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('Appointments')
          .add(appointment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ Booking Confirmed for ${widget.doctor['name']}"),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double doctorFee = widget.doctor['fee'] ?? 3500;

    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: firstNameCtrl,
                    decoration: InputDecoration(labelText: "First Name"),
                    validator:
                        (val) => val!.isEmpty ? "Enter first name" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: lastNameCtrl,
                    decoration: InputDecoration(labelText: "Last Name"),
                    validator: (val) => val!.isEmpty ? "Enter last name" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: InputDecoration(labelText: "Email or Phone"),
                    validator:
                        (val) => val!.isEmpty ? "Enter contact info" : null,
                  ),
                  SizedBox(height: 20),
                  Divider(),

                  Text(
                    "Location & Hospital",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Select District"),
                    value: selectedDistrict,
                    items:
                        districts
                            .map(
                              (d) => DropdownMenuItem(value: d, child: Text(d)),
                            )
                            .toList(),
                    onChanged:
                        (val) =>
                            setState(() => selectedDistrict = val as String),
                    validator: (val) => val == null ? "Select district" : null,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Select Hospital"),
                    value: selectedHospital,
                    items:
                        hospitals
                            .map(
                              (h) => DropdownMenuItem(value: h, child: Text(h)),
                            )
                            .toList(),
                    onChanged:
                        (val) =>
                            setState(() => selectedHospital = val as String),
                    validator: (val) => val == null ? "Select hospital" : null,
                  ),

                  SizedBox(height: 20),
                  Divider(),

                  Text(
                    "Payment Summary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _feeRow("Doctor Fee", doctorFee),
                  _feeRow("Booking Fee", bookingFee),
                  Divider(),
                  _feeRow("Total", doctorFee + bookingFee, isBold: true),
                  SizedBox(height: 30),

                  ElevatedButton.icon(
                    onPressed: bookNow,
                    icon: Icon(Icons.payment),
                    label: Text("Pay Now", style: TextStyle(fontSize: 16)),
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
          ),
        ),
      ),
    );
  }

  Widget _feeRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "Rs. ${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
