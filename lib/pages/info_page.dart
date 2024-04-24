// import 'package:flutter/material.dart';
// import 'package:my_health_core/styles/app_colors.dart';
// import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';

// class MyHealthEducationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text(
//               'My Health Education',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(width: 8.0),
//             Icon(Icons.info_outline, color: Colors.blueGrey),
//           ],
//         ),
//         backgroundColor: AppColors.background,
//         iconTheme: IconThemeData(color: Colors.blueGrey), // Set arrow color
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome to My Health Education!',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Explore a wealth of information and resources to enhance your health knowledge.',
//               style: TextStyle(fontSize: 16.0, color: Colors.lightBlueAccent),
//             ),
//             SizedBox(height: 24.0),
//             Text(
//               'Key Features:',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             FeatureItem(
//                 title: 'Informative Articles',
//                 icon: Icons.article,
//                 details: 'Details about Informative Articles...'),
//             FeatureItem(
//                 title: 'Interactive Quizzes',
//                 icon: Icons.quiz,
//                 details: 'Details about Interactive Quizzes...'),
//             FeatureItem(
//                 title: 'Health Tips',
//                 icon: Icons.lightbulb,
//                 details: 'Details about Health Tips...'),
//             FeatureItem(
//                 title: 'Community Forums',
//                 icon: Icons.forum,
//                 details: 'Details about Community Forums...'),
//             SizedBox(height: 24.0),
//             Text(
//               'How We Support You:',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Our mission is to provide comprehensive support and information on various health topics. We believe in empowering individuals with knowledge to make informed decisions about their well-being.',
//               style: TextStyle(fontSize: 16.0, color: Colors.lightBlueAccent),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Save this Information --->',
//                   style: TextStyle(fontSize: 16.0, color: Colors.white),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement save functionality here
//                     // Add 'feature' to the saved list
//                     // You can use a state management solution for this
//                   },
//                   child: Text('Save'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
//     );
//   }
// }

// class FeatureItem extends StatefulWidget {
//   final String title;
//   final IconData icon;
//   final String details;

//   const FeatureItem({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.details,
//   }) : super(key: key);

//   @override
//   _FeatureItemState createState() => _FeatureItemState();
// }

// class _FeatureItemState extends State<FeatureItem> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(
//               widget.icon,
//             ),
//             title: Row(
//               children: [
//                 Text(
//                   widget.title,
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 SizedBox(width: 8.0),
//                 Icon(
//                   isExpanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                   size: 16.0,
//                 ),
//               ],
//             ),
//             onTap: () {
//               setState(() {
//                 isExpanded = !isExpanded;
//               });
//             },
//           ),
//           if (isExpanded)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 widget.details,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }