import 'package:flutter/material.dart';

class DetailEvent extends StatefulWidget {
  const DetailEvent({super.key});

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
      ),
      body: Center(
        child: Text('Detail Event'),
      ),
    );
  }
}