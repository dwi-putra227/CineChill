import 'package:flutter/material.dart';
import 'package:movie_mcc_lec/Page/home.dart'; // Import HomeScreen
import 'package:movie_mcc_lec/Page/team_profile.dart'; // Import TeamProfileScreen

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0; // Index untuk mengatur halaman yang aktif
  final List<Widget> _screens = [
    HomeScreen(), // Halaman Home
    TeamProfileScreen(), // Halaman Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFF76ABAE),
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex, // Index yang aktif
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Mengubah halaman saat ikon bottom nav diklik
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
