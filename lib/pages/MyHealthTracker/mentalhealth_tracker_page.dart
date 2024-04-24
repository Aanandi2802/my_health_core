import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/pages/MyHealthTracker/mentalhealth_journal_page.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class MentalHealthTrackerPage extends StatefulWidget {
  @override
  _MentalHealthTrackerPageState createState() =>
      _MentalHealthTrackerPageState();
}

class _MentalHealthTrackerPageState extends State<MentalHealthTrackerPage> {
  DateTime selectedDate =
      DateTime.now(); // Tracks the current selected date for logging.
  List<String> selectedSymptoms = []; // List of selected symptoms for the day.
  String? selectedFeeling; // Tracks the user's selected feeling.
  final List<Map<String, dynamic>> mentalHealthLog =
      []; // Logs all entries of mental health tracking.

  // Options for symptoms that can be selected.
  final List<String> symptomOptions = [
    "Anxiety",
    "Depression",
    "Low mood",
    "Sadness",
    "Hopelessness",
    "Irritability",
    "Impulsivity",
    "Grandiose ideas",
    "Racing thoughts",
    "Can't concentrate",
    "Low self-esteem",
  ];

  // Options for feelings that can be selected.
  final List<String> feelingsOptions = [
    "Awful",
    "Bad",
    "Neutral",
    "Good",
    "Great"
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
              CommonWidgets.buildMainHeading('Mental Health Tracker'),
              SizedBox(height: 15.0),
              _dateSelector(),
              _logSymptomsSection(),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MentalHealthJournalPage()),
                  );
                },
                child: Text(
                  'Go to Mental Health Journal',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.saffron,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 15.0),
              _summarySection(),
              SizedBox(height: 20),
              CommonWidgets.buildBottomImage('Mental Health.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Widget for selecting date
  Widget _dateSelector() {
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
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }

  Widget _logSymptomsSection() {
    // Widget for logging symptoms and feelings
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Log Your Symptoms',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: symptomOptions.map((symptom) {
              return ChoiceChip(
                label: Text(symptom),
                selected: selectedSymptoms.contains(symptom),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedSymptoms.add(symptom);
                    } else {
                      selectedSymptoms.remove(symptom);
                    }
                  });
                },
              );
            }).toList(),
          ),
          Center(
            child: DropdownButton<String>(
              value: selectedFeeling,
              hint: Text('I\'m feeling...',
                  style: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  selectedFeeling = value;
                });
              },
              items: feelingsOptions.map((feeling) {
                return DropdownMenuItem(
                  value: feeling,
                  child: Text(feeling, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _logMentalHealth,
              child: Text(
                'Log Mental Health',
                style: TextStyle(
                  color: Colors.black, // Set the text color to black
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.saffron,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to log selected symptoms and feeling to the mental health log
  void _logMentalHealth() {
    if (selectedSymptoms.isEmpty || selectedFeeling == null) {
      _showSnackBar('Please select at least one symptom and feeling.');
      return;
    }

    setState(() {
      mentalHealthLog.add({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'time': DateFormat('HH:mm').format(DateTime.now()),
        'symptoms': selectedSymptoms.join(', '),
        'feeling': selectedFeeling,
      });
      selectedSymptoms.clear();
      selectedFeeling = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Mental health logged successfully.'),
      backgroundColor: Colors.green,
    ));
  }

  // Displays all logged mental health entries
  Widget _summarySection() {
    // Sort the dates in descending order
    final sortedDates = mentalHealthLog
        .map((e) => e['date'] as String)
        .toSet()
        .toList()
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
              title: Text(date, style: TextStyle(color: Colors.black)),
              children: mentalHealthLog
                  .where((log) => log['date'] == date)
                  .map((log) => ListTile(
                        title: Text(
                          log['time'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Symptoms: ${log['symptoms']} \nFeeling: ${log['feeling']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Date picker to select the date
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MentalHealthTrackerPage()));
