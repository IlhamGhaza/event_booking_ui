import 'package:event_booking_app/config/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_theme.dart';

class Eventfragment extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageEvent;
  final String textDate;
  final String textName;
  final String textLocation;
  final String textPrice;
  const Eventfragment(
      {super.key,
      required this.onPressed,
      required this.imageEvent,
      required this.textDate,
      required this.textName,
      required this.textLocation,
      required this.textPrice});

  @override
  Widget build(BuildContext context) {
    double widthQ = MediaQuery.of(context).size.width;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Container(
                width: widthQ,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imageEvent,
                        width: widthQ,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      width: 50,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          textDate,
                          textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   fontSize: 18,
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      textName,
                      maxLines: 1,
                      style: theme.textTheme.titleLarge?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Text(
                    textPrice,
                    style: TextStyle(
                      color: Color(0xff6351ec),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: theme.iconTheme.color,
                  ),
                  SizedBox(width: 5),
                  Text(
                    textLocation,
                    // style: TextStyle(
                    //   color: Colors.black,
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w500,
                    // ),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
