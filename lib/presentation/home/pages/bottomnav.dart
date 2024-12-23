import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../booking/pages/booking.dart';
import '../../profile/pages/profile.dart';
import 'home.dart';
import '../../../config/app_theme.dart';
import '../../../config/bloc/theme_cubit.dart';

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
    super.initState();

    home = HomePage();
    booking = Booking();
    profile = Profile();
    pages = [home, booking, profile];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 65,
            backgroundColor: theme.colorScheme.surface,
            color: theme.primaryColor,
            buttonBackgroundColor: theme.primaryColor,
            animationDuration: Duration(milliseconds: 500),
            items: [
              Icon(Icons.home_outlined,
                  color: theme.colorScheme.onPrimary, size: 30),
              Icon(Icons.book_online,
                  color: theme.colorScheme.onPrimary, size: 30),
              Icon(Icons.person, color: theme.colorScheme.onPrimary, size: 30),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          body: pages[currentIndex],
        );
      },
    );
  }
}
