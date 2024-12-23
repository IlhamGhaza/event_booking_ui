import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_theme.dart';
import '../../../config/bloc/theme_cubit.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int ticketCount = 1;
  final double basePrice = 50000;

  @override
  Widget build(BuildContext context) {
    double widthQ = MediaQuery.of(context).size.width;
    double heightQ = MediaQuery.of(context).size.height;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Image Header Section
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.asset(
                          height: heightQ / 2.3,
                          width: widthQ,
                          'assets/images/event.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: heightQ / 2.3,
                        width: widthQ,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: Icon(Icons.arrow_back, size: 24),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Event Info
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dua Lipa Concert",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "31 December 2024",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(Icons.access_time,
                                          color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "20:00 WIB",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.white, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "Jakarta International Stadium",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Event Details Section
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Event",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Join us for an unforgettable night with global pop sensation Dua Lipa! Experience chart-topping hits, stunning choreography, and state-of-the-art production in this spectacular concert event.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 25),

                        // Ticket Counter
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            // color: Colors.grey[100],
                            color: theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Number of Tickets",
                                // style: TextStyle(
                                //   fontSize: 18,
                                //   fontWeight: FontWeight.bold,
                                // ),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (ticketCount > 1) {
                                        setState(() => ticketCount--);
                                      }
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                    color: Color(0xff6351ec),
                                  ),
                                  Text(
                                    "$ticketCount",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() => ticketCount++);
                                    },
                                    icon: Icon(Icons.add_circle_outline),
                                    color: Color(0xff6351ec),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Purchase Section
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      color: theme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Rp ${(basePrice * ticketCount).toStringAsFixed(0)}",
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff6351ec),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
