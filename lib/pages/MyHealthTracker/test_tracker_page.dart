// test_tracker_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class TestTrackerPage extends StatefulWidget {
  @override
  _TestTrackerPageState createState() => _TestTrackerPageState();
}

class _TestTrackerPageState extends State<TestTrackerPage> {
  DateTime selectedDate =
      DateTime.now(); // Currently selected date for tracking tests.
  String? selectedTestType; // Selected type of medical test.
  String? followUpBooked; // Status if a follow-up is booked.
  List<Map<String, dynamic>> testLog = []; // Log of all test entries.

  final List<String> testTypes = [
    'HIV Standard Test',
    'HIV Self-Test',
  ];

  final TextEditingController resultsController = TextEditingController();

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
              CommonWidgets.buildMainHeading('Track Your Tests'),
              // Date selector interface.
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
              SizedBox(height: 15),
              _logTestContainer(),
              SizedBox(height: 20),
              _addTestResultsContainer(),
              SizedBox(height: 20),
              _summaryContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 2),
    );
  }

  // Container for logging tests.
  Widget _logTestContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Log a Test',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          DropdownButton<String>(
            value: selectedTestType,
            hint:
                Text('Select Test Type', style: TextStyle(color: Colors.white)),
            onChanged: (String? newValue) {
              setState(() {
                selectedTestType = newValue!;
              });
            },
            items: testTypes.map<DropdownMenuItem<String>>((String value) {
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

  // Container for adding test results.
  Widget _addTestResultsContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Add Test Results',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          TextField(
            controller: resultsController,
            decoration: InputDecoration(
              labelText: 'Results',
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          DropdownButton<String>(
            value: followUpBooked,
            hint:
                Text('Follow Up Booked', style: TextStyle(color: Colors.white)),
            onChanged: (String? newValue) {
              setState(() {
                followUpBooked = newValue!;
              });
            },
            items: ['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: _logTestAndResult,
            child: Text('Add Test and Results'),
          ),
        ],
      ),
    );
  }

  // Function to log the test and results.
  void _logTestAndResult() {
    if (selectedTestType == null || selectedTestType!.isEmpty) {
      _showSnackBar('Please select a test type.');
      return;
    }

    if (resultsController.text.trim().isEmpty) {
      _showSnackBar('Please enter the test results.');
      return;
    }

    if (followUpBooked == null) {
      _showSnackBar('Please indicate if follow-up is booked.');
      return;
    }

    setState(() {
      testLog.add({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'type': selectedTestType!,
        'result': resultsController.text.trim(),
        'followUp': followUpBooked!,
      });
      // Reset the fields after logging
      selectedTestType = null;
      followUpBooked = null;
      resultsController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Test and results logged successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Container for displaying summary of logged tests.
  Widget _summaryContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Summary', style: TextStyle(fontSize: 20, color: Colors.white)),
          ..._buildSummaryWidgets(),
        ],
      ),
    );
  }

  List<Widget> _buildSummaryWidgets() {
    // Sort the dates in descending order
    final sortedDates = testLog.map((e) => e['date'] as String).toSet().toList()
      ..sort((a, b) => b.compareTo(a));

    List<Widget> summaryWidgets = [];

    for (String date in sortedDates) {
      summaryWidgets.add(
        ExpansionTile(
          title: Text(date, style: TextStyle(color: Colors.black)),
          children: testLog
              .where((test) => test['date'] == date)
              .map((test) => ListTile(
                    title: Text(
                      test['type'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Result: ${test['result']} \nFollow Up: ${test['followUp']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
              .toList(),
        ),
      );
    }
    return summaryWidgets;
  }

  // Date selection function.
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

void main() => runApp(MaterialApp(home: TestTrackerPage()));
