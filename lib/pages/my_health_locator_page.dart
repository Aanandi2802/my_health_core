import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Defines data structure for each feature in the Locator section of the app.
class LocatorFeatureItemData {
  final String title;
  final IconData icon;

  LocatorFeatureItemData({required this.title, required this.icon});
}

// StatelessWidget for displaying the 'My Health Locator' section.
// This page includes options to locate various health services like ASO, HIV testing, and PrEP clinics.
class MyHealthLocatorPage extends StatelessWidget {
  final List<LocatorFeatureItemData> features = [
    LocatorFeatureItemData(title: 'Locate an ASO', icon: Icons.place),
    LocatorFeatureItemData(title: 'Locate an HIV Test', icon: Icons.search),
    LocatorFeatureItemData(
        title: 'Locate a PrEP Clinic', icon: Icons.local_hospital),
    LocatorFeatureItemData(
        title: 'Locate a Community-Based Organisation', icon: Icons.group),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Locator'),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Find AIDS Service Organizations (ASOs), HIV testing locations, PrEP clinics, and community-based organizations near you.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 24.0),
              // Dynamically generates a list of feature items for the locator section.
              ...features
                  .map((feature) => LocatorFeatureItem(
                        title: feature.title,
                        icon: feature.icon,
                        onTap: () => navigateToLocatorFeaturePage(
                            context, feature.title),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }

  // Navigates to the specific feature page based on the title of the selected feature.
  void navigateToLocatorFeaturePage(BuildContext context, String title) {
    if (title == 'Locate an ASO') {
      Navigator.pushNamed(context, '/locate_aso');
    } else if (title == 'Locate an HIV Test') {
      Navigator.pushNamed(context, '/locate_hiv_test');
    } else if (title == 'Locate a PrEP Clinic') {
      Navigator.pushNamed(context, '/locate_prep_clinic');
    } else if (title == 'Locate a Community-Based Organisation') {
      Navigator.pushNamed(context, '/locate_community_based_organisation');
    }
  }
}

// StatelessWidget to render each feature item as a clickable list tile in the app.
class LocatorFeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const LocatorFeatureItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap:
            onTap, // Executes the onTap callback when the list tile is tapped.
      ),
    );
  }
}
