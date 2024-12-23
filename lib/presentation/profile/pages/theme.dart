import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/bloc/theme_cubit.dart';

class Theme extends StatelessWidget {
   final List<(String, ThemeMode)> _themes = const [
    ('Dark', ThemeMode.dark),
    ('Light', ThemeMode.light),
    ('System', ThemeMode.system),
  ];
  const Theme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOC Change Theme'),
      ),
      body: Center(
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, selectedTheme) {
            return Column(
              children: List.generate(
                _themes.length,
                (index) {
                  final String label = _themes[index].$1;
                  final ThemeMode theme = _themes[index].$2;

                  return ListTile(
                    title: Text(
                      label,
                      style: TextStyle(
                          fontWeight:
                              selectedTheme == theme ? FontWeight.bold : null),
                    ),
                    onTap: () => context.read<ThemeCubit>().updateTheme(theme),
                    trailing: selectedTheme == theme
                        ? Icon(
                            Icons.check,
                          )
                        : null,
                  );
                },
              ),
            );
          },
        )));
  }
}