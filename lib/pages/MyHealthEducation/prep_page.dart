// prep_page.dart

import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';

class PrePPage extends StatelessWidget {
  final Uri _bwvPreventionAndTestingUrl =
      Uri.parse('https://www.bwvisions.ca/prevention-and-testing');
  final Uri _ontarioPreP = Uri.parse('https://ontarioprep.ca/prepstart/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Education'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CommonWidgets.buildMainHeading(
                'PrEP',
              ),
              SizedBox(height: 16),
              CommonWidgets.buildHeading('What is PrEP?'),
              SizedBox(height: 8),
              CommonWidgets.buildText(
                'PrEP, or pre-exposure prophylaxis, is a medication used by people who are HIV '
                'negative to aid in preventing HIV. PrEP comes in pill form and contains two '
                'antiretroviral drugs. These same pills are also used together with other '
                'medications in people living with HIV for HIV treatment. It must be taken as '
                'prescribed to work. The medication is to be taken before, while and after you '
                'may come into contact with HIV.',
              ),
              SizedBox(height: 16),
              CommonWidgets.buildHeading('What types of PreP are available?'),
              SizedBox(height: 8),
              CommonWidgets.buildText(
                'Two PrEP pills are approved by Health Canada. Both pills contain emtricitabine '
                '(also called FTC) plus one other drug – either tenofovir disoproxil fumarate '
                '(also called TDF) or tenofovir alafenamide (also called TAF). TDF + FTC (brand name '
                'Truvada) was the original form of PrEP and it is available in generic drug '
                'formulations. The other combination, TAF + FTC, is only available as the brand '
                'name drug, called Descovy.',
              ),
              SizedBox(height: 16),
              CommonWidgets.buildHeading('Cost:'),
              SizedBox(height: 8),
              CommonWidgets.buildText(
                'The cost of prep can be covered under most public and some private drug plans. For '
                'seniors over 65 years old, Ontarians 24 years and younger, Ontarians enrolled in '
                'Ontario Works, the Ontario Disability Support Program, home care or community care '
                'programs, the cost of PrEP is covered. If you do not fall into any of these categories, '
                'you may be eligible for the Trillium Drug Program.',
              ),
              SizedBox(height: 16),
              CommonWidgets.buildHeading(
                  'The PrEPStart program provides 3 months of PrEP free for people who do not have a drug plan.'),
              CommonWidgets.buildText(
                'It allows you to start PrEP right away and gives you three months to find the drug plan '
                'that’s right for you. Visit OntarioPrEP to get more information about enrolling in the '
                'PrEPStart program.',
              ),
              SizedBox(height: 30),
              CommonWidgets.buildSourcesHeading('Source:'),
              CommonWidgets.buildHyperlink(
                  'Black Women’s Visions - Prevention and Testing',
                  _bwvPreventionAndTestingUrl,
                  context),
              CommonWidgets.buildHyperlink(
                  'OntarioPrEP', _ontarioPreP, context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement save functionality here
        },
        backgroundColor: AppColors.beer,
        child: Icon(Icons.save, color: AppColors.white),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 1),
    );
  }
}
