import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PreventionPage extends StatelessWidget {
  final Uri _bwvSexualHealthUrl =
      Uri.parse('https://www.bwvisions.ca/sexual-health');
  final Uri _catieHivBasicsUrl =
      Uri.parse('https://www.catie.ca/essentials/hiv-basics');

  void _launchUrl(BuildContext context, Uri url) async {
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch the link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Education'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CommonWidgets.buildMainHeading('Prevention'),
            SizedBox(height: 16),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '1.  Condoms and Lube',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Condoms are thin pouches that keep sperm from getting into the vagina. Condoms work by keeping semen, or other fluids, from entering the vagina. The materials used to make most condoms (such as latex, nitrile, polyurethane and polyisoprene) do not let HIV pass through them. Condoms act as a barrier to HIV infection by preventing the vagina, penis, rectum and mouth from being exposed to bodily fluids (such as semen, vaginal fluid and rectal fluid) that can contain HIV.',
                ),
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What types of condoms are there?'),
                SizedBox(height: 8),
                CommonWidgets.buildHeading(
                  '1. External condom', // Add the full content here
                ),
                CommonWidgets.buildText(
                  'An external condom is worn on the penis. This is a sheath made from polyurethane, latex or polyisoprene, which covers the penis during sexual intercourse.', // Add the full content here
                ),
                SizedBox(height: 8),
                CommonWidgets.buildHeading(
                  '2. Internal condom', // Add the full content here
                ),
                CommonWidgets.buildText(
                  'An internal condom is inserted into the vagina. This is a pouch made of polyurethane or nitrile. The internal condom was designed for vaginal sex but can also be used for anal sex. The pouch is open at one end and closed at the other, with a flexible ring at both ends. The ring at the closed end is inserted into the vagina or anus to hold the condom in place. The ring at the open end of the pouch remains outside of the vagina or anus.', // Add the full content here
                ),
                SizedBox(height: 16),
                CommonWidgets.buildHeading('How do I use them?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'The use of internal or external condoms is a highly effective strategy to prevent passing on HIV and other infections. When condoms are used consistently and correctly the chances of passing on HIV is very low. \n\nYou must use new external and internal condoms consistently and correctly for them to be effective.\n\nUsing water-based or silicone-based lubricants helps ensure they do not break.\n\n', // Add the full content here
                ),

                // Include all other details related to "Condoms and Lube" here.
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '2.  HIV Treatment',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '3.  U = U',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '4.  PrEP',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '5.  PEP',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '6.  Not sharing sex toys',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            ExpansionTile(
              title: CommonWidgets.buildHeading(
                '7.  Not sharing drug equipment',
              ),
              children: [
                SizedBox(height: 16),
                CommonWidgets.buildHeading('What are they?'),
                SizedBox(height: 8),
                CommonWidgets.buildText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Augue ut lectus arcu bibendum. Ornare lectus sit amet est. Sed vulputate odio ut enim. Id leo in vitae turpis massa sed elementum tempus egestas. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet commodo. Gravida quis blandit turpis cursus. Dignissim sodales ut eu sem. Mattis rhoncus urna neque viverra.',
                ),
              ],
            ),
            // ...
            CommonWidgets.buildSourcesHeading('Sources'),
            CommonWidgets.buildHyperlink(
                'Black Women’s Visions - HIV and Sexual Health',
                _bwvSexualHealthUrl,
                context),
            CommonWidgets.buildHyperlink(
                'CATIE - HIV Basics', _catieHivBasicsUrl, context),
            // ... Add more links if needed ...
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement save functionality here
        },
        backgroundColor: AppColors.beer,
        child: Icon(Icons.save, color: AppColors.white),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 2),
    );
  }
}
