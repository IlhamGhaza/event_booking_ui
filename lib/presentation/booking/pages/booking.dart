import 'package:event_booking_app/presentation/booking/widget/card_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/app_theme.dart';
import '../../../config/bloc/theme_cubit.dart';
import 'detail_complete.dart';
import 'detail_ongoing.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data statis untuk ongoing dan completed
  final List<Map<String, String?>> allBookingData = [
    {
      "textLocation": "Location A",
      "imagePath": "assets/images/event.jpg",
      "textName": "Event A",
      "textDate": "2024-12-30",
      "textTime": "10:00 AM",
      "textStatus": "Ongoing",
    },
    {
      "textLocation": "Location B",
      "imagePath": "assets/images/event.jpg",
      "textName": "Event B",
      "textDate": "2024-12-31",
      "textTime": "02:00 PM",
      "textStatus": "Completed",
    },
    {
      "textLocation": "Location C",
      "imagePath": "assets/images/event.jpg",
      "textName": "Event C",
      "textDate": "2024-12-31",
      "textTime": "02:00 PM",
      "textStatus": "Completed",
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Booking",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Ongoing"),
                Tab(text: "Completed"),
              ],
              indicatorColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onPrimary,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.secondary,
                  theme.colorScheme.surface,
                  theme.scaffoldBackgroundColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOngoingTemplate(theme),
                _buildCompletedTemplate(theme),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOngoingTemplate(ThemeData theme) {
    final filteredData = allBookingData
        .where((booking) => booking["textStatus"] == "Ongoing")
        .toList();
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final booking = filteredData[index];
        return CardBooking(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailOngoing(),
              ),
            );
          },
          textStatus: booking["textStatus"],
        );
      },
    );
  }

  Widget _buildCompletedTemplate(ThemeData theme) {
    final filteredData = allBookingData
        .where((booking) => booking["textStatus"] == "Completed")
        .toList();
    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final booking = filteredData[index];
        return CardBooking(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailComplete(),
              ),
            );
          },
          textStatus: booking["textStatus"],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
