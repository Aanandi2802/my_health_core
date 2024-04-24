import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Defines a page for initiating chats with peers within the My Health Connect section.
class MainChatWithPeerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setup the top AppBar with the title 'My Health Connect'.
      appBar: CommonWidgets.buildAppBar('My Health Connect'),
      // The body is scrollable to accommodate various screen sizes.
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Heading for the chat page.
            CommonWidgets.buildMainHeading('Chat with a Peer'),
            // Description container to inform users about the feature.
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
            // Button to navigate to the service provider selection page.
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.saffron,
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/select_a_service_provider');
                },
                child: Text('Select a Peer'),
              ),
            ),
            // Display a grid of available peers for connecting.
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                ServiceProviderCard(
                    serviceProviderName: 'Peer 1', iconData: Icons.person),
                ServiceProviderCard(
                    serviceProviderName: 'Peer 2', iconData: Icons.person),
                ServiceProviderCard(
                    serviceProviderName: 'Peer 3', iconData: Icons.person),
                ServiceProviderCard(
                    serviceProviderName: 'Peer 4', iconData: Icons.person),
              ],
            ),
          ],
        ),
      ),
      // Includes a navigation bar at the bottom for app-wide navigation.
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

// Represents a card widget for displaying service provider details.
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
          // Handle tap events for each service provider card.
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50.0, color: Colors.black.withOpacity(0.7)),
              Text(serviceProviderName,
                  style: TextStyle(color: Colors.black.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }
}
