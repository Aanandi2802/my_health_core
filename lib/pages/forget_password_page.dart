// forget_password_page.dart - Manages the user password reset process.
import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Main widget that defines the layout for the forget password functionality
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Use the full height of the device screen
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Spacer(),
                Text(
                  'Forgot Password', // Title for the forgot password page.
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Enter your email address to reset your password', // Instruction text.
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email Address', // Placeholder text.
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors
                        .saffron, // Background color of the text field.
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic to handle password reset request.
                      print('Reset password email sent!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundGreen,
                      foregroundColor: AppColors.white,
                    ),
                    child: Text('Reset Password'),
                  ),
                ),
                Spacer(), // A row to allow users to navigate back to login if they remember their password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember your password?', // Prompt for users who recalled their password.
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to the previous screen.
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppColors.buttonDisplay, // Text button color.
                      ),
                      child: Text(
                        'Sign in!', // Button text to navigate to the login screen.
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
