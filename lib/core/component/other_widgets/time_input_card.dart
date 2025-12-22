import 'package:flutter/material.dart';

class TimeInputCard extends StatefulWidget {
  // The initial time to display.
  final TimeOfDay initialTime;
  // A callback function that executes when the time is successfully picked or when the form is saved.
  final ValueChanged<TimeOfDay> onChanged;

  const TimeInputCard({super.key, required this.initialTime, required this.onChanged});

  @override
  State<TimeInputCard> createState() => _TimeInputCardState();
}

class _TimeInputCardState extends State<TimeInputCard> {
  // Internal state for the displayed time
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  void didUpdateWidget(TimeInputCard oldWidget) {
  
    if (widget.initialTime != oldWidget.initialTime) {
      if (mounted) {
        setState(() {
          _selectedTime = widget.initialTime;
          super.didUpdateWidget(oldWidget);
        });
      }
    }
  }

  // Helper function to format TimeOfDay into a display string (09:00 AM)
  String _formatTime(TimeOfDay time) {
    // Custom simple 12-hour format similar to the image, avoiding intl dependency.
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    // Ensure the hour is 09 instead of 9 for single digit hours in 12hr format
    final hourString = hour.toString().padLeft(2, '0');

    return '$hourString:$minute $period';
  }

Future<void> _pickTime() async {
    if (!mounted) return;

    final ctx = context; // safe local copy

    final pickedTime = await showTimePicker(
      context: ctx, initialTime: _selectedTime,
    );

    if (!mounted) return;

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
      widget.onChanged(pickedTime);
    }
  }

  // Extract time, minute, and AM/PM for styling
  List<String> _parseDisplayTime() {
    final timeText = _formatTime(_selectedTime);
    final parts = timeText.split(' '); // [09:00, AM]
    if (parts.length != 2) return ['--:--', ''];

    final time = parts[0]; // 09:00
    final period = parts[1]; // AM or PM
    return [time, period];
  }

  @override
  Widget build(BuildContext context) {
    final parsedTime = _parseDisplayTime();
    final time = parsedTime[0];
    final period = parsedTime[1];

    return InkWell(
      onTap: _pickTime,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey.shade300, // Light gray border like the image
            width: 1.5,
          ),
          boxShadow: [
            // Optional: subtle shadow for depth
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Time (HH:MM) - Bold and large
            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            // AM/PM - Smaller and lighter
            Text(
              period,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 8),
            // Icon - Double arrow (like in the image)
            Icon(
              Icons.unfold_more, // Used as a close visual equivalent
              size: 24,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
