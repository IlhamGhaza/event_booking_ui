import 'package:event_booking_app/config/bloc/theme_cubit.dart';
import 'package:event_booking_app/test_page.dart';
import 'package:event_booking_app/presentation/home/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../../config/app_theme.dart';
import '../widget/iconbar-fragment.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocation = prefs.getString('last_location');

    if (savedLocation != null) {
      setState(() {
        location = savedLocation;
      });
    } else {
      _getLastKnownLocation();
    }
  }

  Future<void> _saveLocation(String loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_location', loc);
  }

  Future<void> _getLastKnownLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          location = "Location services are disabled";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            location = "Location permissions are denied";
          });
          return;
        }
      }

      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        await _getAddressFromLatLong(position.latitude, position.longitude);
      } else {
        setState(() {
          location = "No last known location found";
        });
      }
    } catch (e) {
      setState(() {
        location = "Error: $e";
      });
    }
  }

  Future<void> _getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      String newLocation = "${place.locality}, ${place.country}";
      await _saveLocation(newLocation);
      setState(() {
        location = newLocation;
      });
    } catch (e) {
      setState(() {
        location = "Failed to get address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthQ = MediaQuery.of(context).size.width;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                width: widthQ,
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
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          location,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, User',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          'There are 300+ event\naround your location',
                          style: TextStyle(
                            color: Color(0xff6351ec),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      width: widthQ,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search an event',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category Events',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xff6351ec),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double maxWidth = constraints.maxWidth;

                            int visibleCount =
                                _getVisibleCategoryCount(maxWidth);

                            double itemWidth =
                                (maxWidth - (visibleCount - 1) * 8) /
                                    visibleCount;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 8.0,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ..._categories.take(visibleCount).map(
                                          (category) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            child: IconBarFragment(
                                              imagePath: category['imagePath']!,
                                              text: category['text']!,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>TestPage()
                                                    // builder: (context) =>
                                                    //     CategoryPage(
                                                    //   category: category,
                                                    // ),
                                                  ),
                                                );
                                              },
                                              width: itemWidth,
                                            ),
                                          ),
                                        ),
                                    // if (_categories.length > visibleCount)
                                    //   Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 4.0),
                                    //     child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       child: Text('See All'),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Upcoming Events',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xff6351ec),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return EventCard(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _getVisibleCategoryCount(double maxWidth) {
    if (maxWidth >= 1000) {
      return 6;
    } else if (maxWidth >= 800) {
      return 5;
    } else {
      return maxWidth >= 400 ? 3 : 2;
    }
  }

  List<Map<String, String>> get _categories => [
        {"imagePath": "assets/images/music.png", "text": "Music"},
        {"imagePath": "assets/images/music.png", "text": "Clothing"},
        {"imagePath": "assets/images/music.png", "text": "Festival"},
        {"imagePath": "assets/images/music.png", "text": "Art"},
        {"imagePath": "assets/images/music.png", "text": "Food"},
        {"imagePath": "assets/images/music.png", "text": "Tech"},
        {"imagePath": "assets/images/music.png", "text": "Sports"},
      ];
}
