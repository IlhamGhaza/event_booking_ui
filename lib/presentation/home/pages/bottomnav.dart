import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../booking/pages/booking.dart';
import '../../profile/pages/profile.dart';
import 'home.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;
  late HomePage home;
  late Booking booking;
  late Profile profile;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    home = HomePage();
    booking = Booking();
    profile = Profile();
    pages = [home, booking, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xffe3e6ff), // Matches gradient from home
        color: Color(0xff6351ec), // Main purple color from home
        buttonBackgroundColor: Color(0xff6351ec), // Keep consistent
        animationDuration: Duration(milliseconds: 500),
        items: [
          Icon(Icons.home_outlined, color: Colors.white, size: 30),
          Icon(Icons.book_online, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}
