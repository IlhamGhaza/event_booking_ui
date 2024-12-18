import 'package:flutter/material.dart';

class IconBarFragment extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final String text;
  const IconBarFragment({super.key, required this.imagePath, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        elevation: 3,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
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
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
