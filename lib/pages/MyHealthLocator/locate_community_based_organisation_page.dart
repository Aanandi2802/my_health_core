// locate_community_based_organisation.dart

import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class LocateCommunityBasedOrganisationPage extends StatelessWidget {
  // Replace with your actual URL
  final Uri _googleUrl = Uri.parse('https://www.google.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar(
        'My Health Locator',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CommonWidgets.buildMainHeading(
                'Locate a Community Based Organisation',
              ),
              SizedBox(height: 16),
              CommonWidgets.buildCenterText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Aliquam ac sapien eget elit semper porttitor sed vel orci. '
                'Ut suscipit, nulla nec ultricies interdum, purus dui dictum tellus, '
                'id commodo justo libero eget ante.',
              ),
              SizedBox(height: 30),
              CommonWidgets.buildSourcesHeading('Sources'),
              SizedBox(height: 8),
              CommonWidgets.buildHyperlink('Google Link', _googleUrl, context),
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
