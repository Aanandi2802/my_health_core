// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// CommonWidgets is a utility class that contains static methods to create reusable UI components across the app.
/// This class helps maintain consistency and reduces code duplication.

class CommonWidgets {
  /// Builds the AppBar with a uniform style used across various screens in the app.
  static AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.appbarHeading,
      centerTitle: true,
    );
  }

  /// Builds the main heading for pages, ensuring visual consistency.
  static Widget buildMainHeading(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.saffron,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }

  /// Additional methods like `buildHeading`, `buildText`, and `buildHyperlink` serve similar purposes,
  /// providing styled text and interactive elements.

  //building subheadings
  static Widget buildHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.bananaMania,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //building style for source type headings
  static Widget buildSourcesHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.bananaMania,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  //common text style
  static Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: AppColors.white,
      ),
    );
  }

//for adding content in the center
  static Widget buildCenterText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: AppColors.white,
      ),
    );
  }

  // //for bullet points
  // static Widget buildBulletPoint(String text) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: 8.0),
  //     child: Text(
  //       '• $text',
  //       style: TextStyle(fontSize: 18, color: AppColors.white),
  //     ),
  //   );
  // }

  //build hyperlink texts
  static Widget buildHyperlink(String text, Uri url, BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(url)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $text')),
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: AppColors
              .beer, // Ensure the underline is the same color as the text
          decorationThickness: 1, // Make the underline thicker
          color: AppColors.beer, // Tex/ Make it bold to indicate it's clickable
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  //bullet points method
  static List<Widget> buildBulletPoints(List<String> points) {
    return points
        .map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(fontSize: 18, color: AppColors.white)),
                  Expanded(
                    child: Text(
                      point,
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  //testing_page.dart
  //method to build testing method
  static Widget buildTestingMethodSection(
      BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.font,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 18, color: AppColors.white),
        ),
      ],
    );
  }

  static Widget buildBottomImage(String imageName) {
    double borderRadius = 8.0; // Default border radius
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            borderRadius), // Use the default border radius
        child: Image.asset(
          'assets/images/$imageName',
          fit: BoxFit.cover, // You can adjust this as needed
        ),
      ),
    );
  }

  // Add more common methods or widgets if necessary
}
