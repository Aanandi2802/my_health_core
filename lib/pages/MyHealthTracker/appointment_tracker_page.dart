import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Defines a stateful widget for tracking appointments.
class AppointmentTrackerPage extends StatefulWidget {
  @override
  _AppointmentTrackerPageState createState() => _AppointmentTrackerPageState();
}

class _AppointmentTrackerPageState extends State<AppointmentTrackerPage> {
  // Holds the date for the appointment, defaulting to the current day.
  DateTime selectedDate = DateTime.now();

  // Currently chosen type of appointment from the dropdown.
  String? selectedAppointmentType;

  // Options available for selecting the type of appointment.
  final List<String> appointmentTypes = [
    'New appointment',
    'Follow up appointment'
  ];

  // Controls the text input for appointment notes.
  final TextEditingController notesController = TextEditingController();

  // Stores a record of all appointments added during the session.
  List<Map<String, dynamic>> appointmentLog = [];

  // Holds the choice of service provider selected by the user.
  String? selectedServiceProvider;

  // Dropdown menu options for selecting a service provider.
  final List<String> serviceProviders = [
    'Physician',
    'Pharmacist',
    'Social Worker',
    'Nutritionist'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Tracker'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CommonWidgets.buildMainHeading('Track Your Appointments'),
              Center(
                child: IconButton(
                  icon: Icon(Icons.calendar_today, size: 40.0),
                  onPressed: () => _selectDate(context),
                ),
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(selectedDate),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),
              _logAppointmentContainer(),
              SizedBox(height: 5),
              _addNotesContainer(),
              SizedBox(height: 5),
              _serviceProviderSelection(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addAppointment,
                child: Text(
                  'Add Appointment',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.saffron,
                ),
              ),
              SizedBox(height: 10),
              _summaryContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Dropdown to select a service provider.
  Widget _serviceProviderSelection() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: selectedServiceProvider,
        hint: Text('Select Service Provider',
            style: TextStyle(color: Colors.white)),
        onChanged: (String? newValue) {
          setState(() {
            selectedServiceProvider = newValue;
          });
        },
        items: serviceProviders.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }

  // Adds a new appointment to the log.
  void _addAppointment() {
    if (selectedAppointmentType == null || selectedServiceProvider == null) {
      _showSnackBar(
          'Please select an appointment type and a service provider.');
      return;
    }

    setState(() {
      appointmentLog.add({
        'date': selectedDate,
        'type': selectedAppointmentType!,
        'serviceProvider': selectedServiceProvider!,
        'notes': notesController.text.trim(),
      });
      selectedAppointmentType = null;
      selectedServiceProvider = null;
      notesController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment added successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Container for logging a new appointment.
  Widget _logAppointmentContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Log an Appointment',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          DropdownButton<String>(
            value: selectedAppointmentType,
            hint: Text('Select Appointment Type',
                style: TextStyle(color: Colors.white)),
            onChanged: (String? newValue) {
              setState(() {
                selectedAppointmentType = newValue;
              });
            },
            items:
                appointmentTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Text field for adding notes to the appointment.
  Widget _addNotesContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: notesController,
        decoration: InputDecoration(
            labelText: 'Appointment Notes',
            labelStyle: TextStyle(color: Colors.white)),
        style: TextStyle(color: Colors.white),
        maxLines: 3,
      ),
    );
  }

  // summary
  Widget _summaryContainer() {
    // Sort the appointments by date in descending order
    appointmentLog.sort((a, b) => b['date'].compareTo(a['date']));

    // Group the appointments by date
    Map<String, List<Map<String, dynamic>>> groupedAppointments = {};
    for (var appointment in appointmentLog) {
      String dateKey = DateFormat('yyyy-MM-dd').format(appointment['date']);
      if (!groupedAppointments.containsKey(dateKey)) {
        groupedAppointments[dateKey] = [];
      }
      groupedAppointments[dateKey]!.add(appointment);
    }

    // Sort the dates in descending order
    List<String> sortedDates = groupedAppointments.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Summary', style: TextStyle(fontSize: 20, color: Colors.white)),
          ...sortedDates.map((date) {
            return ExpansionTile(
              title: Text(date, style: TextStyle(color: Colors.white)),
              children: groupedAppointments[date]!.map((appointment) {
                return ListTile(
                  title: Text(
                    '${appointment['type']} - ${appointment['serviceProvider']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: appointment['notes'].isNotEmpty
                      ? Text(
                          'Notes: ${appointment['notes']}',
                          style: TextStyle(color: Colors.white),
                        )
                      : null,
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Function to handle date selection.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Shows a SnackBar with a message.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AppointmentTrackerPage()));
