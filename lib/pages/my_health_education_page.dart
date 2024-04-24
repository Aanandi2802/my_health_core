import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

// MyHealthEducationPage provides a list of educational topics related to HIV, allowing users to explore various resources.
class MyHealthEducationPage extends StatefulWidget {
  @override
  _MyHealthEducationPageState createState() => _MyHealthEducationPageState();
}

// FeatureItemData holds the title and icon for each feature in the education section.
class FeatureItemData {
  final String title;
  final IconData icon;

  FeatureItemData({required this.title, required this.icon});
}

// Manages the state of MyHealthEducationPage, including filtering and displaying features.
class _MyHealthEducationPageState extends State<MyHealthEducationPage> {
  late List<FeatureItemData> filteredFeatures;
  // allFeatures lists all the available features within the education section.
  final List<FeatureItemData> allFeatures = [
    FeatureItemData(title: 'HIV 101', icon: Icons.library_books),
    FeatureItemData(title: 'Testing', icon: Icons.local_hospital),
    FeatureItemData(title: 'Prevention', icon: Icons.shield),
    FeatureItemData(title: 'PrEP', icon: Icons.medical_services),
    FeatureItemData(title: 'Treatment', icon: Icons.healing),
    FeatureItemData(title: 'How-to\'s', icon: Icons.lightbulb),
    FeatureItemData(title: 'Open Core Quiz', icon: Icons.question_answer),
    FeatureItemData(title: 'HIV Disclosure', icon: Icons.visibility),
    FeatureItemData(title: 'HIV and Ageing', icon: Icons.accessibility_new),
    FeatureItemData(
        title: 'HIV and Disability', icon: Icons.accessible_forward),
    FeatureItemData(title: 'HIV and Pregnancy', icon: Icons.pregnant_woman),
    FeatureItemData(title: 'HIV Stigma', icon: Icons.sentiment_dissatisfied),
    FeatureItemData(title: 'Sexual health', icon: Icons.favorite),
    FeatureItemData(title: 'SDOH and HIV', icon: Icons.group_work),
    FeatureItemData(title: 'HIV Care', icon: Icons.medical_information),
  ];

  @override
  void initState() {
    super.initState();
    // Initializes filteredFeatures with all items from allFeatures on state creation.
    filteredFeatures = List.from(allFeatures);
  }

  // filterFeatures updates the list of features displayed based on the user's search query.
  void filterFeatures(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredFeatures = List.from(allFeatures);
      });
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    setState(() {
      filteredFeatures = allFeatures.where((feature) {
        return feature.title.toLowerCase().contains(lowercaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Education'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search input for filtering features
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  style: TextStyle(
                    color: AppColors.font,
                  ),
                  onChanged: filterFeatures,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: AppColors.font,
                    ),
                    prefixIcon: Icon(Icons.search, color: AppColors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            // Information container about the features
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Explore a wealth of information and resources to enhance your health knowledge about HIV.',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            // List of features available for navigation
            SizedBox(height: 24.0),
            ...filteredFeatures
                .map((feature) => FeatureItem(
                      title: feature.title,
                      icon: feature.icon,
                      onTap: () =>
                          navigateToFeaturePage(context, feature.title),
                    ))
                .toList(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

// navigateToFeaturePage handles navigation based on the title of the feature selected.
void navigateToFeaturePage(BuildContext context, String title) {
  String routeName = '';
  switch (title) {
    case 'HIV 101':
      routeName = '/hiv_101';
      break;
    case 'Testing':
      routeName = '/testing';
      break;
    case 'Prevention':
      routeName = '/prevention';
      break;
    case 'PrEP':
      routeName = '/prep';
      break;
    case 'Treatment':
      routeName = '/treatment';
      break;
    case 'How-to\'s':
      routeName = '/how_tos';
      break;
    case 'Open Core Quiz':
      routeName = '/open_core_quiz';
      break;
    case 'HIV Disclosure':
      routeName = '/hiv_disclosure';
      break;
    case 'HIV and Ageing':
      routeName = '/hiv_and_ageing';
      break;
    case 'HIV and Disability':
      routeName = '/hiv_and_disability';
      break;
    case 'HIV and Pregnancy':
      routeName = '/hiv_and_pregnancy';
      break;
    case 'HIV Stigma':
      routeName = '/hiv_stigma';
      break;
    case 'Sexual health':
      routeName = '/sexual_health';
      break;
    case 'SDOH and HIV':
      routeName = '/sdoh_and_hiv';
      break;
    case 'HIV Care':
      routeName = '/hiv_care';
      break;
    // ... other cases ...
    default:
      print('No route defined for this title');
      return;
  }
  Navigator.pushNamed(context, routeName);
}

class FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureItem({
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
