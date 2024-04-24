import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class MentalHealthJournalPage extends StatefulWidget {
  @override
  _MentalHealthJournalPageState createState() =>
      _MentalHealthJournalPageState();
}

class _MentalHealthJournalPageState extends State<MentalHealthJournalPage> {
  List<Map<String, dynamic>> journalEntries = []; // Stores all journal entries
  TextEditingController _journalController =
      TextEditingController(); // Controls text input for journal entries
  DateTime selectedDate =
      DateTime.now(); // Holds currently selected date for journal entries

  @override
  void dispose() {
    _journalController.dispose(); // Properly dispose of the controller
    super.dispose();
  }

  // Adds a new blank entry and clears the text field
  void _addNewEntry() {
    setState(() {
      _journalController.clear();
    });
  }

  // Saves the current journal entry to the log
  void _saveEntry() {
    if (_journalController.text.isNotEmpty) {
      setState(() {
        journalEntries.insert(0, {
          'date': DateTime.now(), // Use the current date and time
          'entry': _journalController.text,
        });
        _journalController.clear();
      });
    }
  }

  // Opens a date picker to select the date for a journal entry
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('Mental Health Tracker'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CommonWidgets.buildMainHeading('Mental Health Journal'),
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
              ElevatedButton(
                onPressed: _addNewEntry,
                child: Text(
                  'New Entry',
                  style:
                      TextStyle(color: Colors.black), // Make text color black
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.saffron, // Button background color
                ),
              ),
              TextField(
                controller: _journalController,
                decoration: InputDecoration(
                  hintText: 'Type your thoughts here...',
                  hintStyle: TextStyle(
                      color: AppColors.chocolateCosmos.withOpacity(0.6)),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.chocolateCosmos),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gold),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                maxLines: 5,
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: _saveEntry,
                child: Text(
                  'Save Entry',
                  style:
                      TextStyle(color: Colors.black), // Make text color black
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.saffron, // Button background color
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildJournalEntries(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Builds a list of journal entries, grouped by date
  Widget _buildJournalEntries() {
    // Group the entries by date
    Map<String, List<Map<String, dynamic>>> groupedEntries = {};
    for (var entry in journalEntries) {
      String dateKey = DateFormat('yyyy-MM-dd').format(entry['date']);
      if (!groupedEntries.containsKey(dateKey)) {
        groupedEntries[dateKey] = [];
      }
      groupedEntries[dateKey]!.add(entry);
    }

    // Sort the dates in descending order
    List<String> sortedDates = groupedEntries.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Old Entries',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          ...sortedDates.map((date) {
            return ExpansionTile(
              title: Text(
                date,
                style: TextStyle(color: Colors.white),
              ),
              children: groupedEntries[date]!.map((subEntry) {
                return ListTile(
                  title: Text(
                    DateFormat('HH:mm').format(subEntry['date']),
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    subEntry['entry'],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MentalHealthJournalPage()));
