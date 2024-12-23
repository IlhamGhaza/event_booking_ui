import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_theme.dart';
import '../../../config/bloc/theme_cubit.dart';

class IconBarFragment extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String text;
  const IconBarFragment(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return InkWell(
          onTap: () {},
          child: Material(
            elevation: 3,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                    color: theme.colorScheme.onSurface,
                  ),
                  Text(
                    text,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
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
