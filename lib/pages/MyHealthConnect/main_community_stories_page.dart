import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Displays a page featuring community stories within the My Health Connect app.
class MainCommunityStoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Connect'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.0),
            CommonWidgets.buildMainHeading(
              'Community Stories',
            ),
            SizedBox(height: 24.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Connect with healthcare professionals to get the support you need.',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 24.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                ServiceProviderCard(
                  serviceProviderName: 'Story 1',
                  iconData: Icons.library_books,
                ),
                ServiceProviderCard(
                  serviceProviderName: 'Story 2',
                  iconData: Icons.library_books,
                ),
                ServiceProviderCard(
                  serviceProviderName: 'Story 3',
                  iconData: Icons.library_books,
                ),
                ServiceProviderCard(
                  serviceProviderName: 'Story 4',
                  iconData: Icons.library_books,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

// Card widget to represent each story in the community stories page.
class ServiceProviderCard extends StatelessWidget {
  final String serviceProviderName;
  final IconData iconData;

  ServiceProviderCard({
    Key? key,
    required this.serviceProviderName,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          // Implement navigation logic based on the serviceProviderName
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, size: 50.0, color: Colors.black.withOpacity(0.7)),
              Text(
                serviceProviderName,
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
