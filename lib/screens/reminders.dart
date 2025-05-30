import 'package:flutter/material.dart';

class Reminder {
  final String type;
  final DateTime dateTime;

  Reminder({required this.type, required this.dateTime});
}

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<Reminder> _reminders = [];
  bool _showForm = false;

  String? _selectedReminderType;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _reminderTypes = [
    'Electricity Bill',
    'Rent Payment',
    'Mobile Recharge',
    'Credit Card Bill',
    'SIP Investment Reminder',
  ];

  void _setReminder() {
    if (_selectedReminderType != null &&
        _selectedDate != null &&
        _selectedTime != null) {
      final fullDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      setState(() {
        _reminders.add(
          Reminder(type: _selectedReminderType!, dateTime: fullDateTime),
        );
        _selectedReminderType = null;
        _selectedDate = null;
        _selectedTime = null;
        _showForm = false;
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.alarm),
                      title: Text(reminder.type),
                      subtitle: Text('${reminder.dateTime}'),
                    ),
                  );
                },
              ),
            ),
            if (_showForm)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: _selectedReminderType,
                    hint: const Text("Select Reminder Type"),
                    isExpanded: true,
                    items: _reminderTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedReminderType = value),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _selectedDate == null
                          ? 'Pick Date'
                          : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                    onPressed: _pickDate,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(
                      _selectedTime == null
                          ? 'Pick Time'
                          : _selectedTime!.format(context),
                    ),
                    onPressed: _pickTime,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _setReminder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Set Reminder"),
                  ),
                ],
              ),
            if (!_showForm)
              ElevatedButton.icon(
                icon: const Icon(Icons.add_alert),
                label: const Text("Set New Reminder"),
                onPressed: () => setState(() => _showForm = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
