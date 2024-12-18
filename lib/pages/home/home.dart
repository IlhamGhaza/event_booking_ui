import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

import 'detail_event.dart';
import 'fragment/event-fragment.dart';
import 'fragment/iconbar-fragment.dart';

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

  // Muat lokasi terakhir yang disimpan
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

  // Simpan lokasi ke SharedPreferences
  Future<void> _saveLocation(String loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_location', loc);
  }

  // Mendapatkan lokasi terakhir
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

  // Konversi latitude & longitude ke alamat
  Future<void> _getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      String newLocation =
          "${place.locality}, ${place.country}"; // Contoh: Jakarta, Indonesia
      await _saveLocation(newLocation); // Simpan lokasi
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            width: widthQ,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffe3e6ff),
                  Color(0xfff1f3ff),
                  Colors.white,
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
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // shimmer effect for location
                    // showFallback || location != "Loading..."
                    //     ? Text(
                    //         location,
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       )
                    //     : Shimmer.fromColors(
                    //         baseColor: Colors.grey[300]!,
                    //         highlightColor: Colors.grey[100]!,
                    //         child: Container(
                    //           width: 120,
                    //           height: 20,
                    //           color: Colors.grey[300],
                    //         ),
                    //       ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, User',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    color: Colors.white,
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
                    IconBarFragment(
                        imagePath: "assets/images/music.png",
                        text: "Music",
                        onPressed: () {}),
                    IconBarFragment(
                        imagePath: "assets/images/music.png",
                        text: "Clothing",
                        onPressed: () {}),
                    IconBarFragment(
                        imagePath: "assets/images/music.png",
                        text: "Festival",
                        onPressed: () {}),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Events',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                //event list
                Column(
                  children: [
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Eventfragment(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailEvent(),
                                    ),
                                  );
                                },
                                imageEvent: 'assets/images/event.jpg',
                                textDate: 'Aug\n24',
                                textName: 'Dua Lipa',
                                textLocation: 'Jakarta, Indonesia',
                                textPrice: 'Rp. 1.000.000',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
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
  }
}
