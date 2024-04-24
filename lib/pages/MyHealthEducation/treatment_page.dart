import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TreatmentPage extends StatelessWidget {
  final Uri _url =
      Uri.parse('https://www.google.com'); // Replace with your actual URL

  // Function to handle launching URLs
  void _launchUrl(BuildContext context) async {
    try {
      if (!await launchUrl(_url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch the link.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Education'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CommonWidgets.buildMainHeading(
                'Treatment',
              ),
              SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Aliquam ac sapien eget elit semper porttitor sed vel orci. '
                'Ut suscipit, nulla nec ultricies interdum, purus dui dictum tellus, '
                'id commodo justo libero eget ante.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.bananaMania,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Sources',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bananaMania,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _launchUrl(context),
                child: Text(
                  'www.google.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.saffron,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // Add more Text widgets for additional links as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement save functionality here
        },
        backgroundColor: AppColors.beer,
        child: Icon(Icons.save, color: AppColors.white),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 1),
    );
  }
}
