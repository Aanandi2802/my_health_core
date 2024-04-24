// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// HomePage is a StatefulWidget that displays the main dashboard of the app.
/// It includes features like a search bar, latest news carousel, and quick access to major app features.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeatureItemData> allFeatures = [
    FeatureItemData(title: 'MyHealthEducation', icon: Icons.school),
    FeatureItemData(title: 'MyHealthConnect', icon: Icons.people_alt),
    FeatureItemData(title: 'MyHealthLocator', icon: Icons.location_pin),
    FeatureItemData(title: 'MyHealthTracker', icon: Icons.track_changes),
  ]; // List of all features available in the app.

  List<FeatureItemData> filteredFeatures =
      []; // Filtered list based on search query.

  void _launchURL(String url) async {
    if (!await canLaunch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    } else {
      await launch(url);
    }
  }

  @override
  void initState() {
    super.initState();
    filteredFeatures.addAll(allFeatures);
  }

  void filterFeatures(String keyword) {
    setState(() {
      // Filters the main features list based on the search keyword.
      filteredFeatures = allFeatures
          .where((feature) =>
              feature.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Core'),
      body: SingleChildScrollView(
        // Page layout starts here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar implementation
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
            // Latest news carousel
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Latest News',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.white,
                        shadows: [
                          Shadow(
                            color: AppColors.black.withOpacity(0.5),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(height: 225.0, autoPlay: true),
                    items: [
                      CarouselItemData(
                        title:
                            'Commentary: After 40 years of AIDS, why do we still not have an HIV vaccine?',
                        imageUrl: 'assets/images/news1.png',
                        hyperlink:
                            'https://www.channelnewsasia.com/commentary/hiv-aids-vaccine-40-years-testing-treatment-trials-4210821',
                      ),
                      CarouselItemData(
                        title: 'Scientists say they can cut HIV out of cells',
                        imageUrl: 'assets/images/news2.png',
                        hyperlink: 'https://www.bbc.com/news/health-68609297',
                      ),
                      CarouselItemData(
                        title:
                            'Major change is coming - long acting PrEP (Pre-Exposure Prophylaxis)',
                        imageUrl: 'assets/images/news3.png',
                        hyperlink:
                            'https://www.catie.ca/treatmentupdate-250/major-change-is-coming-long-acting-hiv-pre-exposure-prophylaxis',
                      ),
                      // Add more items as needed
                    ].map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _launchURL(item.hyperlink),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: AppColors.carousel_background,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor:
                                        AppColors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Quick feature access list
                  for (var feature in filteredFeatures)
                    FeatureItem(title: feature.title, icon: feature.icon),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

class CarouselItemData {
  final String title;
  final String imageUrl;
  final String hyperlink;

  CarouselItemData({
    required this.title,
    required this.imageUrl,
    required this.hyperlink,
  });
}

class FeatureItemData {
  final String title;
  final IconData icon;

  FeatureItemData({
    required this.title,
    required this.icon,
  });
}

class FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const FeatureItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToFeaturePage(String routeName) {
      Navigator.pushNamed(context, routeName);
    }

    String routeName = '';
    switch (title) {
      case 'MyHealthEducation':
        routeName = '/my_health_education';
        break;
      case 'MyHealthConnect':
        routeName = '/my_health_connect';
        break;
      case 'MyHealthLocator':
        routeName = '/my_health_locator';
        break;
      case 'MyHealthTracker':
        routeName = '/my_health_tracker';
        break;
      default:
        // Handle default case
        break;
    }

    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          navigateToFeaturePage(routeName);
        },
      ),
    );
  }
}
