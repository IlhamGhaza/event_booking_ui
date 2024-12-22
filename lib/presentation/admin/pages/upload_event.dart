import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _eventDetailController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  File? _selectedImage;
  String? _selectedCategory;

  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Concert',
    "Music",
    "Sports",
    "Conference",
    "Art",
    "Technology",
    "Education"
  ];

  Future<void> _requestGalleryPermission() async {
    // Check if the platform is Android and handle versions
    if (Platform.isAndroid) {
      if (await Permission.photos.isPermanentlyDenied) {
        openAppSettings();
      } else {
        final status = await Permission.photos.request();
        if (status.isGranted) {
          _pickImage();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Please allow access to gallery to select images',
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> _pickImage() async {
    await _requestGalleryPermission();
    final status = await Permission.photos.status;

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please allow access to gallery to select images',
          ),
        ),
      );
    }
  }

  @override

  /// Builds a screen to upload an event.
  ///
  /// The screen has the following components:
  ///
  /// - A button to pick an image from the gallery.
  /// - A text field to enter the event name.
  /// - A text field to enter the event price.
  /// - A dropdown button to select a category.
  /// - A text field to enter the event details.
  /// - A button to add the event.
  ///
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Add New Event",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _selectedImage == null
                          ? const Icon(Icons.camera_alt_outlined)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price (USD)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: categories
                        .map(
                          (category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setDialogState) {
                              return AlertDialog(
                                title: const Text('Pick Event Date and Time'),
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: SfDateRangePicker(
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                          onSelectionChanged:
                                              (DateRangePickerSelectionChangedArgs
                                                  args) {
                                            if (args.value is PickerDateRange) {
                                              setDialogState(() {
                                                _startDate =
                                                    args.value.startDate;
                                                _endDate = args.value.endDate ??
                                                    args.value.startDate;
                                              });
                                              // Update parent state
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime:
                                                _startTime ?? TimeOfDay.now(),
                                          );
                                          if (pickedTime != null) {
                                            setDialogState(() {
                                              _startTime = pickedTime;
                                            });
                                            // Update parent state
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          _startTime != null
                                              ? 'Start Time: ${_startTime!.format(context)}'
                                              : 'Pick Start Time',
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime:
                                                _endTime ?? TimeOfDay.now(),
                                          );
                                          if (pickedTime != null) {
                                            setDialogState(() {
                                              _endTime = pickedTime;
                                            });
                                            // Update parent state
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          _endTime != null
                                              ? 'End Time: ${_endTime!.format(context)}'
                                              : 'Pick End Time',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              _startDate != null &&
                                      _endDate != null &&
                                      _startTime != null &&
                                      _endTime != null
                                  ? 'Start: ${_startDate!.toLocal().toIso8601String().split('T')[0]} ${_startTime!.format(context)}\n'
                                      'End: ${_endDate!.toLocal().toIso8601String().split('T')[0]} ${_endTime!.format(context)}'
                                  : 'Pick Date & Time Range',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _eventDetailController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Event Details',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff6351ec),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff6351ec).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_eventNameController.text.isEmpty ||
                              _selectedImage == null ||
                              _priceController.text.isEmpty ||
                              _selectedCategory == null ||
                              _startDate == null ||
                              _startTime == null ||
                              _endDate == null ||
                              _endTime == null ||
                              _eventDetailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Please fill in all fields',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            //logic to add event

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Event Added Successfully!')),
                            );

                            setState(() {
                              _eventNameController.clear();
                              _priceController.clear();
                              _selectedCategory = null;
                              _startDate = null;
                              _endDate = null;
                              _startTime = null;
                              _endTime = null;
                              _selectedImage = null;
                              _eventDetailController.clear();
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: const Center(
                          child: Text(
                            'Add Event',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
