// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Manages and tracks the user's medication schedule and history.
class MedicationTrackerPage extends StatefulWidget {
  @override
  _MedicationTrackerPageState createState() => _MedicationTrackerPageState();
}

class _MedicationTrackerPageState extends State<MedicationTrackerPage> {
  // Stores the currently selected date for logging medication.
  DateTime selectedDate = DateTime.now();
  // Tracks the type of medication selected from a predefined list.
  String? selectedMedicationType;
  // Indicates whether the full dosage was taken.
  bool fullDosageTaken = true;
  // Logs the history of medications taken, including details like date, type, and side effects.
  List<Map<String, dynamic>> medicationLog = [];
  // Tracks custom medications added by the user.
  List<Map<String, dynamic>> addedMedications = [];

  // Available types of medications.
  final List<String> medicationTypes = [
    'Select your medication',
    'ART - Single Fixed Dose',
    'ART - Combination Fixed Dose',
    'ART - Injectable',
    'PrEP',
    'PEP',
  ];

  // Possible side effects that can be selected.
  final List<String> sideEffectOptions = [
    "None",
    "Rash",
    "Skin darkening",
    "Redness",
    "Blisters",
    "Muscle or joint ache",
    "Pain",
    "Swelling",
    "Weight gain",
    "Weight loss",
    "Dry mouth",
    "Nausea",
    "Vomiting",
    "Diarrhea",
    "Vivid dreams",
    "Anxiety",
    "Depression",
    "Insomnia",
    "Suicidal Ideation",
  ];

  // Controllers for custom medication name and dosage inputs.
  final customMedController = TextEditingController();
  final dosageController = TextEditingController();
  // Currently selected side effect.
  String? selectedSideEffect;
  bool _isLogging = false;

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
              CommonWidgets.buildMainHeading('Medication Tracker'),
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
              _logMedicationContainer(),
              SizedBox(height: 20),
              _addMedicationContainer(),
              SizedBox(height: 20),
              _summaryContainer(),
              SizedBox(height: 20),
              CommonWidgets.buildBottomImage('Medication.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Contains dropdowns to select medication type and side effects, and a switch to indicate if the full dosage was taken.
  Widget _logMedicationContainer() {
    // Container to log the medication with all options
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Log Your Medication',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          // Creates a dropdown menu for selecting medication types.
          DropdownButton<String>(
            value: selectedMedicationType,
            hint: Text('Select Medication Type',
                style: TextStyle(color: Colors.white)),
            onChanged: (String? newValue) {
              setState(() {
                selectedMedicationType = newValue!;
              });
            },
            items:
                medicationTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          // Creates a dropdown menu for selecting any side effects experienced.
          DropdownButton<String>(
            value: selectedSideEffect,
            hint: Text('Select Side Effect',
                style: TextStyle(color: Colors.white)),
            onChanged: (String? newValue) {
              setState(() {
                selectedSideEffect = newValue!;
              });
            },
            items:
                sideEffectOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          // Creates a switch to record whether the full dosage of medication was taken.
          SwitchListTile(
            title: Text('Full Dosage Taken',
                style: TextStyle(color: Colors.white)),
            value: fullDosageTaken,
            onChanged: (bool value) {
              setState(() {
                fullDosageTaken = value;
              });
            },
            activeColor: Colors.white,
            activeTrackColor: AppColors.gold,
          ),
          ElevatedButton(
            onPressed: _isLogging ? null : _logMedication,
            child: Text('Log Medication'),
          ),
        ],
      ),
    );
  }

  // Adds the logged medication to the medication log.
  void _logMedication() {
    if (selectedMedicationType == null ||
        selectedMedicationType!.isEmpty ||
        selectedMedicationType == 'Select your medication') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a medication type before logging.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Proceed with logging the medication
    setState(() {
      medicationLog.add({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'type': selectedMedicationType!,
        'dosage': fullDosageTaken ? 'Full Dosage' : 'Not Full Dosage',
        'sideEffects': selectedSideEffect ?? 'None',
      });

      // Reset the selected medication type to enforce selection for next log
      selectedMedicationType = null;
    });

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Medication logged successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Provides UI for adding a new medication with its name and dosage.
  Widget _addMedicationContainer() {
    // Container to add medications
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Add Medication',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
          TextField(
            controller: customMedController,
            decoration: InputDecoration(
                labelText: 'Medication Name',
                labelStyle: TextStyle(color: Colors.white)),
            style: TextStyle(color: Colors.white),
          ),
          TextField(
            controller: dosageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Dosage (mg)',
                labelStyle: TextStyle(color: Colors.white)),
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: _addMedication,
            child: Text('Add Medication'),
          ),
        ],
      ),
    );
  }

  // Adds a new medication to the list of medications being tracked.
  void _addMedication() {
    String name = customMedController.text.trim();
    String dosage = dosageController.text.trim() + " mg";

    // Perform a simple validation to ensure that a medication name and a numeric dosage are entered
    if (name.isEmpty || dosage.isEmpty) {
      _showSnackBar('Please enter the medication name and dosage.');
      return;
    }

    if (int.tryParse(dosageController.text.trim()) == null) {
      _showSnackBar('Please enter a valid number for dosage.');
      return;
    }

    setState(() {
      addedMedications.add({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'name': name,
        'dosage': dosage,
      });
      customMedController.clear();
      dosageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Medication added successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Displays a message at the bottom of the screen using a snack bar.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Displays a summary of all logged and added medications.
  Widget _summaryContainer() {
    // Group the medications by date
    Map<String, List<Map<String, dynamic>>> groupedMedications = {};
    for (var log in medicationLog) {
      groupedMedications.putIfAbsent(log['date'], () => []).add(log);
    }
    for (var med in addedMedications) {
      groupedMedications.putIfAbsent(med['date'], () => []).add(med);
    }

    // Sort the dates in descending order
    List<String> sortedDates = groupedMedications.keys.toList()
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
          ...sortedDates.map(
            (date) => ExpansionTile(
              title: Text(date, style: TextStyle(color: Colors.black)),
              children: groupedMedications[date]!
                  .map(
                    (med) => ListTile(
                      title: Text(
                        med.containsKey('type')
                            ? '${med['type']} - ${med['dosage']}'
                            : '${med['name']} - ${med['dosage']}',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: med.containsKey('sideEffects')
                          ? Text(
                              'Side Effects: ${med['sideEffects']}',
                              style: TextStyle(color: Colors.white),
                            )
                          : null,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Opens a date picker to select the date for logging medication.
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
}

//BELOW CODE IS FOR ADDING ANALYTICS CHART from library fl_chart.dart
//This feature is not implemented and was just in development mode.
// // ignore_for_file: prefer_const_constructors

// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:my_health_core/styles/app_colors.dart';
// import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
// import 'package:my_health_core/widgets/common_widgets.dart';

// class MedicationTrackerPage extends StatefulWidget {
//   @override
//   _MedicationTrackerPageState createState() => _MedicationTrackerPageState();
// }

// class _MedicationTrackerPageState extends State<MedicationTrackerPage> {
//   DateTime selectedDate = DateTime.now();
//   String? selectedMedicationType;
//   bool fullDosageTaken = true;
//   List<Map<String, dynamic>> medicationLog = [];
//   List<Map<String, dynamic>> addedMedications = [];
//   Map<String, Map<String, int>> analyticsData = {};
//   Map<String, int> medicationCounts = {};

//   final List<String> medicationTypes = [
//     'Select your medication',
//     'ART - Single Fixed Dose',
//     'ART - Combination Fixed Dose',
//     'ART - Injectable',
//     'PrEP',
//     'PEP',
//   ];

//   final List<String> sideEffectOptions = [
//     "None",
//     "Rash",
//     "Skin darkening",
//     "Redness",
//     "Blisters",
//     "Muscle or joint ache",
//     "Pain",
//     "Swelling",
//     "Weight gain",
//     "Weight loss",
//     "Dry mouth",
//     "Nausea",
//     "Vomiting",
//     "Diarrhea",
//     "Vivid dreams",
//     "Anxiety",
//     "Depression",
//     "Insomnia",
//     "Suicidal Ideation",
//   ];

//   final customMedController = TextEditingController();
//   final dosageController = TextEditingController();
//   String? selectedSideEffect;
//   bool _isLogging = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonWidgets.buildAppBar('My Health Tracker'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               CommonWidgets.buildMainHeading('Medication Tracker'),
//               Center(
//                 child: IconButton(
//                   icon: Icon(Icons.calendar_today, size: 40.0),
//                   onPressed: () => _selectDate(context),
//                 ),
//               ),
//               Text(
//                 DateFormat('yyyy-MM-dd').format(selectedDate),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               SizedBox(height: 15),
//               _logMedicationContainer(),
//               SizedBox(height: 20),
//               _addMedicationContainer(),
//               SizedBox(height: 20),
//               _summaryContainer(),
//               SizedBox(height: 20),
//               _buildAnalyticsSection(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
//     );
//   }

//   Widget _logMedicationContainer() {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundGreen,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Text(
//             'Log Your Medication',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           DropdownButton<String>(
//             value: selectedMedicationType,
//             hint: Text('Select Medication Type',
//                 style: TextStyle(color: Colors.white)),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedMedicationType = newValue!;
//               });
//             },
//             items:
//                 medicationTypes.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: TextStyle(color: Colors.black)),
//               );
//             }).toList(),
//           ),
//           DropdownButton<String>(
//             value: selectedSideEffect,
//             hint: Text('Select Side Effect',
//                 style: TextStyle(color: Colors.white)),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedSideEffect = newValue!;
//               });
//             },
//             items:
//                 sideEffectOptions.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: TextStyle(color: Colors.black)),
//               );
//             }).toList(),
//           ),
//           SwitchListTile(
//             title: Text('Full Dosage Taken',
//                 style: TextStyle(color: Colors.white)),
//             value: fullDosageTaken,
//             onChanged: (bool value) {
//               setState(() {
//                 fullDosageTaken = value;
//               });
//             },
//             activeColor: Colors.white,
//             activeTrackColor: AppColors.gold,
//           ),
//           ElevatedButton(
//             onPressed: _isLogging ? null : _logMedication,
//             child: Text('Log Medication'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnalyticsSection() {
//     List<FlSpot> spots = _generateDataSpots();

//     // Check if there are no spots and return a placeholder widget or similar.
//     if (spots.isEmpty) {
//       return Center(child: Text('No data available'));
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Container(
//         height: 300, // You can adjust this height to fit your design.
//         child: LineChart(
//           LineChartData(
//             gridData: FlGridData(show: true),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: _getBottomTitles,
//                   reservedSize: 30, // Reserve space for the titles.
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: _getLeftTitles,
//                   reservedSize: 40, // Reserve space for the titles.
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: true),
//             minX: 0, // Start your axis from the index 0.
//             maxX: spots.length.toDouble(), // The end index of your data.
//             minY: 0, // Start your Y axis with 0.
//             maxY: _findMaxY(spots), // The maximum count you have + padding.
//             lineBarsData: [
//               LineChartBarData(
//                 spots: spots,
//                 isCurved: true,
//                 color: Colors.blueAccent,
//                 barWidth: 4,
//                 dotData: FlDotData(show: true, getDotPainter: _getDotPainter),
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// // This method generates the spots for the chart based on your medicationCounts.
//   List<FlSpot> _generateDataSpots() {
//     List<FlSpot> spots = [];
//     double index = 0;
//     medicationCounts.forEach((date, count) {
//       spots.add(FlSpot(index, count.toDouble()));
//       index++;
//     });
//     return spots;
//   }

// // Finds the maximum Y value from the spots to set the maxY in the chart data.
//   double _findMaxY(List<FlSpot> spots) {
//     // If there are no spots, return 0 or some default value for maxY.
//     if (spots.isEmpty) {
//       return 0;
//     }
//     // Otherwise, find the maximum Y value from the spots to set the maxY in the chart data.
//     return spots.map((spot) => spot.y).reduce(max) +
//         2; // Add a margin for better visualization.
//   }

// // Provides a custom style for the dot on the data point.
//   FlDotPainter _getDotPainter(
//       FlSpot spot, double xPercentage, LineChartBarData bar, int index) {
//     return FlDotCirclePainter(
//       radius: 4, // Dot size
//       color: Colors.deepOrange, // Dot color
//       strokeWidth: 2, // Dot border width
//       strokeColor: Colors.white, // Dot border color
//     );
//   }

// // Returns a widget for the bottom titles.
//   SideTitleWidget _getBottomTitles(double value, TitleMeta meta) {
//     const TextStyle textStyle = TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//       fontSize: 10,
//     );

//     // Return a text widget for the x axis based on the value.
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4, // Space from the chart
//       child: Text(_getFormattedDate(value), style: textStyle),
//     );
//   }

// // Returns a formatted date string for the bottom titles.
//   String _getFormattedDate(double value) {
//     // You will need to adapt this method to return the correct date string for each value.
//     // Here's a placeholder implementation.
//     if (value < medicationCounts.keys.length) {
//       String date = medicationCounts.keys.elementAt(value.toInt());
//       DateTime parsedDate = DateTime.parse(date);
//       return DateFormat('MM/dd').format(parsedDate);
//     }
//     return '';
//   }

// // Returns a widget for the left titles.
//   SideTitleWidget _getLeftTitles(double value, TitleMeta meta) {
//     const TextStyle textStyle = TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//       fontSize: 10,
//     );

//     // Return a text widget for the y axis based on the value.
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4, // Space from the chart
//       child: Text(value.toInt().toString(), style: textStyle),
//     );
//   }

// // Assuming you have a List<Map<String, dynamic>> called 'medicationLog' or similar that tracks each medication instance
//   void _updateChartData() {
//     // Clear old data
//     medicationCounts.clear();

//     // Group and count medications by date
//     medicationLog.forEach((medication) {
//       String date = medication['date'];
//       medicationCounts.update(date, (existingValue) => existingValue + 1,
//           ifAbsent: () => 1);
//     });

//     // Call setState if you're updating the chart dynamically
//     setState(() {});
//   }

//   void _logMedication() {
//     if (selectedMedicationType == null ||
//         selectedMedicationType!.isEmpty ||
//         selectedMedicationType == 'Select your medication') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please select a medication type before logging.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//     String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

//     setState(() {
//       medicationLog.add({
//         'date': DateFormat('yyyy-MM-dd').format(selectedDate),
//         'type': selectedMedicationType!,
//         'dosage': fullDosageTaken ? 'Full Dosage' : 'Not Full Dosage',
//         'sideEffects': selectedSideEffect ?? 'None',
//       });
//       _updateAnalytics(DateFormat('yyyy-MM-dd').format(selectedDate), 'logs');
//       medicationCounts.update(formattedDate, (value) => value + 1,
//           ifAbsent: () => 1);

//       selectedMedicationType = null;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Medication logged successfully.'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   Widget _addMedicationContainer() {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundGreen,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Text('Add Medication',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//               )),
//           TextField(
//             controller: customMedController,
//             decoration: InputDecoration(
//                 labelText: 'Medication Name',
//                 labelStyle: TextStyle(color: Colors.white)),
//             style: TextStyle(color: Colors.white),
//           ),
//           TextField(
//             controller: dosageController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//                 labelText: 'Dosage (mg)',
//                 labelStyle: TextStyle(color: Colors.white)),
//             style: TextStyle(color: Colors.white),
//           ),
//           ElevatedButton(
//             onPressed: _addMedication,
//             child: Text('Add Medication'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addMedication() {
//     String name = customMedController.text.trim();
//     String dosage = dosageController.text.trim() + " mg";

//     if (name.isEmpty || dosage.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter the medication name and dosage.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       addedMedications.add({
//         'date': DateFormat('yyyy-MM-dd').format(selectedDate),
//         'name': name,
//         'dosage': dosage,
//       });
//       _updateAnalytics(
//           DateFormat('yyyy-MM-dd').format(selectedDate), 'additions');
//       customMedController.clear();
//       dosageController.clear();
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Medication added successfully.'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   Widget _summaryContainer() {
//     Map<String, List<Map<String, dynamic>>> groupedMedications = {};
//     for (var log in medicationLog) {
//       groupedMedications.putIfAbsent(log['date'], () => []).add(log);
//     }
//     for (var med in addedMedications) {
//       groupedMedications.putIfAbsent(med['date'], () => []).add(med);
//     }

//     List<String> sortedDates = groupedMedications.keys.toList()
//       ..sort((a, b) => b.compareTo(a));

//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: AppColors.backgroundGreen,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Text('Summary', style: TextStyle(fontSize: 20, color: Colors.white)),
//           ...sortedDates.map(
//             (date) => ExpansionTile(
//               title: Text(date, style: TextStyle(color: Colors.black)),
//               children: [
//                 ...groupedMedications[date]!
//                     .map(
//                       (med) => ListTile(
//                         title: Text(
//                           med.containsKey('type')
//                               ? '${med['type']} - ${med['dosage']}'
//                               : '${med['name']} - ${med['dosage']}',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         subtitle: med.containsKey('sideEffects')
//                             ? Text(
//                                 'Side Effects: ${med['sideEffects']}',
//                                 style: TextStyle(color: Colors.white),
//                               )
//                             : null,
//                       ),
//                     )
//                     .toList(),
//                 ListTile(
//                   title: Text(
//                     'Analytics',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'Logs: ${analyticsData[date]?['logs'] ?? 0}, Additions: ${analyticsData[date]?['additions'] ?? 0}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   void _updateAnalytics(String date, String type) {
//     analyticsData.putIfAbsent(date, () => {'logs': 0, 'additions': 0});
//     analyticsData[date]![type] = (analyticsData[date]![type] ?? 0) + 1;
//   }
// }
