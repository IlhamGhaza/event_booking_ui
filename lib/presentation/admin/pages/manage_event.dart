import 'package:flutter/material.dart';

import 'upload_event.dart';

class ManageEvent extends StatefulWidget {
  const ManageEvent({super.key});

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Event'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UploadEvent(),
                    ),
                  );
                },
                child: const Text('Add New Event'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 0, // Replace with actual event count
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: const Text(
                            'Event Name'), // Replace with actual event name
                        subtitle: const Text(
                            'Event Date'), // Replace with actual event date
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Edit event logic
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Delete event logic
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
