// profile_page.dart - Manages user profile settings and data display.
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// Defines the stateful widget for the Profile page.
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for text fields to handle user input.
  final TextEditingController _usernameController =
      TextEditingController(text: 'TestUser');
  final TextEditingController _emailController =
      TextEditingController(text: 'testuser@example.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'password123');
  final TextEditingController _fullNameController =
      TextEditingController(text: 'Test User');
  String _profileImage = 'assets/avatars/avatar1.png'; // Default profile image.

  // Displays a confirmation dialog for various actions.
  Future<bool> _showConfirmationDialog(String title, String content) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Confirm')),
            ],
          ),
        )) ??
        false; // Return false if the dialog is dismissed without any selection.
  }

  // Allows the user to change their profile image.
  void _changeProfileImage() async {
    int avatarCount = 16; // Total number of available avatars.
    List<String> avatars = List.generate(
      avatarCount,
      (index) => 'assets/avatars/avatar${index + 1}.png',
    );

    String selectedAvatar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an Avatar'),
          content: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.0, // Space between avatar options.
              children: avatars.map((String avatar) {
                return InkWell(
                  onTap: () =>
                      Navigator.of(context).pop(avatar), // Selects the avatar.
                  child: Image.asset(avatar, width: 100, height: 90),
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedAvatar != null) {
      final bool confirmed = await _showConfirmationDialog(
        'Change Avatar',
        'Would you like to change your avatar to this one?',
      );

      if (confirmed) {
        setState(() => _profileImage = selectedAvatar);
      }
    }
  }

  // Saves the user profile after confirmation.
  void _saveProfile() async {
    final bool confirmed = await _showConfirmationDialog(
      'Save Profile',
      'Are you sure you want to save these changes?',
    );

    if (confirmed) {
      // Implement save logic here, e.g., update the database or server.
      print('Profile saved with:');
      print('Username: ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Full Name: ${_fullNameController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 40),
              GestureDetector(
                onTap: _changeProfileImage,
                child: Container(
                  width: 100.0, // Profile image size.
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(_profileImage),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Full Name field.
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: AppColors.white)),
                style: TextStyle(color: AppColors.white),
              ),
              SizedBox(height: 16),
              // Username field.
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: AppColors.white)),
                style: TextStyle(color: AppColors.white),
              ),
              SizedBox(height: 16),
              // Email field.
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: AppColors.white)),
                style: TextStyle(color: AppColors.white),
              ),
              SizedBox(height: 16),
              // Password field.
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppColors.white)),
                obscureText: true,
                style: TextStyle(color: AppColors.white),
              ),
              SizedBox(height: 24),
              // Save button.
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(primary: AppColors.saffron),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 2),
    );
  }
}
