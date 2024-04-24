import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';

class SelectProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select a Service Provider',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child:
            Text('Provider selection functionality will be implemented here.'),
      ),
      // Add more functionality as needed
    );
  }
}
