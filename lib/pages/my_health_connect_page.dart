import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Defines data structure for each feature in the Connect section of the app.
class ConnectFeatureItemData {
  final String title;
  final IconData icon;

  ConnectFeatureItemData({required this.title, required this.icon});
}

// StatelessWidget for displaying the 'My Health Connect' section.
// This page includes options to interact with community stories, service providers, and peers.
class MyHealthConnectPage extends StatelessWidget {
  final List<ConnectFeatureItemData> features = [
    ConnectFeatureItemData(title: 'Community Stories', icon: Icons.people),
    ConnectFeatureItemData(
        title: 'Chat with a Service Provider', icon: Icons.chat),
    ConnectFeatureItemData(title: 'Chat with a Peer', icon: Icons.forum),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Connect'),
      // Centers the content and allows vertical scrolling.
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Decorative container providing a brief intro to the page functionality.
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Connect with your community and healthcare professionals for support and guidance.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 24.0),
              // Dynamically generates a list of feature items for the connect section.
              ...features
                  .map((feature) => ConnectFeatureItem(
                        title: feature.title,
                        icon: feature.icon,
                        onTap: () => navigateToConnectFeaturePage(
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
  void navigateToConnectFeaturePage(BuildContext context, String title) {
    if (title == 'Community Stories') {
      Navigator.pushNamed(context, '/main_community_stories');
    }
    if (title == 'Chat with a Service Provider') {
      Navigator.pushNamed(context, '/main_chat_with_service_provider');
    }
    if (title == 'Chat with a Peer') {
      Navigator.pushNamed(context, '/main_chat_with_peer');
    }
  }
}

// StatelessWidget to render each feature item as a clickable list tile in the app.
class ConnectFeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ConnectFeatureItem({
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
        onTap: onTap,
      ),
    );
  }
}
