//bottom-navigation bar

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemNavigator.pop
import 'package:my_health_core/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  AppBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) async {
        // Handle "Quick Exit"
        if (index == 3) {
          // Open Google weather search and exit app
          const url = 'https://www.google.com/search?q=weather';
          if (await canLaunch(url)) {
            await launch(url);
            // Optionally exit the app
            SystemNavigator.pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open the browser.')),
            );
          }
          return;
        }

        // Navigate to different pages based on the index
        switch (index) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
            break;
          case 1:
            if (ModalRoute.of(context)?.settings.name != '/saved') {
              Navigator.pushNamed(context, '/saved');
            }
            break;
          case 2:
            if (ModalRoute.of(context)?.settings.name != '/profile') {
              Navigator.pushNamed(context, '/profile');
            }
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app),
          label: 'Quick Exit',
        ),
      ],
      backgroundColor: AppColors.bottomNavigation,
      unselectedItemColor: AppColors.font,
      selectedItemColor: AppColors.white,
      // Additional properties for more customization:
      type: BottomNavigationBarType.fixed, // Fixes the background color
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      showUnselectedLabels: true, // Shows all labels
    );
  }
}
