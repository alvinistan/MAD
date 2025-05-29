// import 'package:flutter/material.dart';
// import 'screens/home_screen.dart';
// import 'screens/categories_screen.dart';
// import 'screens/appointments_screen.dart';
// import 'screens/messages_screen.dart';
// import 'screens/profile_screen.dart';

// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});

//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     HomeScreen(),
//     CategoriesScreen(),
//     AppointmentsScreen(),
//     MessagesScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() => _currentIndex = index);
//         },
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'screens/home_screen.dart';
// import 'screens/categories_screen.dart';
// import 'screens/appointments_screen.dart';
// import 'screens/messages_screen.dart';
// import 'screens/profile_screen.dart';

// class MainNavigation extends StatefulWidget {
//   final String userId;

//   const MainNavigation({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int _currentIndex = 0;

//   late final List<Widget> _screens;

//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       HomeScreen(userId: widget.userId),
//       CategoriesScreen(),
//       AppointmentsScreen(),
//       MessagesScreen(userId: widget.userId),
//       ProfileScreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() => _currentIndex = index);
//         },
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final String userId;

  const MainNavigation({Key? key, required this.userId}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Screens list includes userId where needed
  late final List<Widget> _screens = [
    HomeScreen(userId: widget.userId),
    CategoriesScreen(),
    AppointmentsScreen(),
    MessagesScreen(userId: widget.userId),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
