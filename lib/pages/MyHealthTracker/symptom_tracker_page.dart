import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class SymptomTrackerPage extends StatefulWidget {
  @override
  _SymptomTrackerPageState createState() => _SymptomTrackerPageState();
}

class _SymptomTrackerPageState extends State<SymptomTrackerPage> {
  DateTime selectedDate =
      DateTime.now(); // Current selected date for logging symptoms.
  TimeOfDay selectedTime =
      TimeOfDay.now(); // Current selected time for logging symptoms.
  String? selectedSymptomType; // Currently selected type of symptom.
  List<String> selectedSymptoms = []; // List of selected symptoms.
  String? selectedSeverity; // Selected severity of symptoms.
  final List<String> severities = [
    'Mild',
    'Moderate',
    'Severe'
  ]; // Options for symptom severity.

  // Detailed categories of symptoms for logging.
  final Map<String, List<String>> symptomDetails = {
    'Cognitive': [
      'Brain fog',
      'Memory loss',
      'Poor concentration',
      'Change in mood'
    ],
    'Respiratory': [
      'Dry cough',
      'Wet cough',
      'Shortness of breath',
      'Sneezing',
      'Stuffy nose',
      'Drainage down back of throat'
    ],
    'Fever': ['Chills', 'Sweating', 'Confusion'],
    'Aches/Pains': [
      'Headache',
      'Body aches',
      'Sore throat',
      'Ear pain',
      'Leg pain',
      'Back pain',
      'Joint pain'
    ],
    'Ear/Nose/Throat': [
      'Stuffy nose',
      'Runny nose',
      'Loss of smell/taste',
      'Drainage down back of throat',
      'Ear pain',
      'Blocked ears'
    ],
    'Eyes': ['Itchy eyes', 'Discharge from eyes', 'Burning eyes'],
    'Digestive': [
      'Stomach pain',
      'Diarrhea',
      'Nausea',
      'Vomiting',
      'Constipation',
      'Bloody stool'
    ],
    'Skin': ['Rash', 'Eczema', 'Hives', 'Acne'],
  };
  // Log of all symptom entries.
  List<Map<String, dynamic>> symptomLog = [];

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
              CommonWidgets.buildMainHeading('Track Your Symptoms'),
              _dateSelectionSection(),
              SizedBox(height: 10),
              _timeSelectionSection(),
              _symptomTypeDropdown(),
              SizedBox(height: 10),
              if (selectedSymptomType != null) _symptomChecklist(),
              SizedBox(height: 10),
              _severityDropdown(),
              SizedBox(height: 10),
              _logSymptomButton(),
              SizedBox(height: 10),
              _symptomSummary(),
              SizedBox(height: 20),
              CommonWidgets.buildBottomImage('Symptoms.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Button to log selected symptoms.
  Widget _logSymptomButton() {
    return ElevatedButton(
      onPressed: _logSymptom,
      child: Text(
        'Log Symptom',
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.saffron,
      ),
    );
  }

  // Selector for the date.
  Widget _dateSelectionSection() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('yyyy-MM-dd').format(selectedDate),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 24.0, color: Colors.white),
            onPressed: () => _selectDate(),
          ),
        ],
      ),
    );
  }

  // Selector for the time.
  Widget _timeSelectionSection() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('HH:mm').format(
              DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              ),
            ),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.access_time, size: 24.0, color: Colors.white),
            onPressed: () => _selectTime(),
          ),
        ],
      ),
    );
  }

  // Dropdown for selecting the symptom type.
  Widget _symptomTypeDropdown() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedSymptomType,
        decoration: InputDecoration(
          labelText: 'Select Symptom Type',
          fillColor: AppColors.backgroundGreen,
          filled: true,
          labelStyle: TextStyle(color: Colors.white), // Change this line
        ),
        onChanged: (value) {
          setState(() {
            selectedSymptomType = value;
            selectedSymptoms.clear();
          });
        },
        items:
            symptomDetails.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  // Checklist for selecting specific symptoms related to the chosen type.
  Widget _symptomChecklist() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specific Symptoms',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          ...symptomDetails[selectedSymptomType]!.map((symptom) {
            return CheckboxListTile(
              value: selectedSymptoms.contains(symptom),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedSymptoms.add(symptom);
                  } else {
                    selectedSymptoms.remove(symptom);
                  }
                });
              },
              title: Text(symptom, style: TextStyle(color: Colors.white)),
              activeColor: AppColors.beer,
              checkColor: Colors.white,
            );
          }).toList(),
        ],
      ),
    );
  }

  // Dropdown to select the severity of the symptoms.
  Widget _severityDropdown() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedSeverity,
        decoration: InputDecoration(
          labelText: 'Select Severity',
          fillColor: AppColors.backgroundGreen,
          filled: true,
          labelStyle: TextStyle(color: Colors.white), // Change this line
        ),
        onChanged: (value) {
          setState(() {
            selectedSeverity = value;
          });
        },
        items: severities.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  void _selectDate() async {
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

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Function to log symptoms along with selected date, time, type, and severity.
  void _logSymptom() {
    if (selectedSymptomType != null &&
        selectedSeverity != null &&
        selectedSymptoms.isNotEmpty) {
      setState(() {
        symptomLog.add({
          'date': DateFormat('yyyy-MM-dd').format(selectedDate),
          'time': selectedTime.format(context),
          'symptomType': selectedSymptomType,
          'specificSymptoms': List.from(selectedSymptoms),
          'severity': selectedSeverity,
        });
        selectedSymptoms.clear();
        selectedSymptomType = null;
        selectedSeverity = null;
      });
    }
  }

  // Displays a summary of all logged symptoms.
  Widget _symptomSummary() {
    // Sort the symptom logs by date and time in descending order
    symptomLog.sort((a, b) {
      var dateCompare = b['date'].compareTo(a['date']);
      if (dateCompare == 0) {
        return b['time'].compareTo(a['time']);
      }
      return dateCompare;
    });

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Symptom Summary',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          for (var log in symptomLog) ...[
            ExpansionTile(
              title: Text(
                '${log['date']} ${log['time']}',
                style: TextStyle(color: Colors.white),
              ),
              children: [
                ListTile(
                  title: Text(
                    '${log['symptomType']}: ${log['specificSymptoms'].join(', ')}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Severity: ${log['severity']}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: SymptomTrackerPage()));
