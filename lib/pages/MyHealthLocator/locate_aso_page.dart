import 'package:flutter/material.dart';
import 'package:my_health_core/styles/app_colors.dart';
import 'package:my_health_core/widgets/app_bottom_navigation_bar.dart';
import 'package:my_health_core/widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

// Defines a stateful widget to locate AIDS Service Organizations (ASOs) across different provinces.
class LocateASOPage extends StatefulWidget {
  @override
  _LocateASOPageState createState() => _LocateASOPageState();
}

class _LocateASOPageState extends State<LocateASOPage> {
  // Currently selected province in dropdown.
  String? selectedProvince;

  // Maps of ASO data organized by province. Each province has a list of ASOs with details.
  Map<String, List<Map<String, String>>> asoDataByProvince = {
    'Alberta': [
      {
        'name': 'HIV Edmonton',
        'mapsUrl':
            'https://www.google.com/maps/dir//HIV+Edmonton,+9702+111+Ave+NW,+Edmonton,+AB+T5G+0B2/',
        'address': '9702 111 Ave. NW',
        'city': 'Edmonton',
        'province': 'AB',
        'postalCode': 'T5G 0B1',
        'phone': '780-488-5742',
        'email': '',
      },
      {
        'name': 'The SHARP Foundation',
        'mapsUrl':
            'https://www.google.com/maps/dir//The+SHARP+Foundation,+5717+2+St+SW,+Calgary,+AB+T2H+0A1/',
        'address': 'A023 5717 2nd Street SW',
        'city': 'Calgary',
        'province': 'AB',
        'postalCode': 'T2H 0A1',
        'phone': '403-272-2912',
        'email': 'info@thesharpfoundation.com',
      },
      {
        'name': 'SafeLink Alberta',
        'mapsUrl':
            'https://www.google.com/maps/dir//SafeLink+Alberta,+1944+10+Ave+SW,+Calgary,+AB+T3C+0J8/',
        'address': '1944 10 Ave SW',
        'city': 'Calgary',
        'province': 'AB',
        'postalCode': 'T3C 0J8',
        'phone': '403-508-2500',
        'email': 'info@safelinkalberta.ca',
      },
    ],
    'British Columbia': [
      {
        'name': 'AIDS Vancouver',
        'mapsUrl':
            'https://www.google.com/maps/dir//AIDS+Vancouver,+1101+Seymour+St+4th+Floor,+Vancouver,+BC+V6B+0R1/',
        'address': '1101 Seymour St 4th Floor',
        'city': 'Vancouver',
        'province': 'BC',
        'postalCode': 'V6B 0R1',
        'phone': '604-893-2201',
        'email': '',
      },
      // Add additional ASOs for British Columbia here
    ],
    'Manitoba': [
      {
        'name': 'Manitoba HIV Program',
        'mapsUrl':
            'https://www.google.com/maps/dir//Nine+Circles+Community+Health+Centre,+705+Broadway,+Winnipeg,+MB+R3G+0X2/',
        'address': '705 Broadway Ave',
        'city': 'Winnipeg',
        'province': 'MB',
        'postalCode': 'R3G 0X2',
        'phone': '866-449-0165',
        'email': '',
      },
    ],
    'Newfoundland & Labrador': [
      {
        'name': 'AIDS Committee of Newfoundland & Labrador',
        'mapsUrl':
            'https://www.google.com/maps/dir//AIDS+Committee+of+Newfoundland+and+Labrador,+47+Janeway+Pl,+St.+John\'s,+NL+A1A+1R7/',
        'address': '47 Janeway Pl',
        'city': 'St. John’s',
        'province': 'NL',
        'postalCode': 'A1A 1R7',
        'phone': '709-579-8656',
        'email': '',
      },
    ],
    'Nova Scotia': [
      {
        'name': 'AIDS Coalition of Nova Scotia',
        'mapsUrl':
            'https://www.google.com/maps/dir/44.6381262,-63.5923892/AIDS+Coalition+of+Nova+Scotia,+5516+Spring+Garden+Rd+Suite+200,+Halifax,+NS+B3J+1G6/',
        'address': '200-5516 Spring Garden Road',
        'city': 'Halifax',
        'province': 'NS',
        'postalCode': 'B3J 1G6',
        'phone': '902-425-4882',
        'email': 'ps@acns.ns.ca',
      },
      {
        'name': 'The Red Door',
        'mapsUrl':
            'https://www.google.com/maps/dir/44.6381262,-63.5923892/Red+Door,+10+Webster+St+suite+110,+Kentville,+NS+B4N+1H7/',
        'address': '110-10 Webster Street',
        'city': 'Kentville',
        'province': 'NS',
        'postalCode': 'B4N 1H4',
        'phone': '902-679-1411',
        'email': 'info@thereddoor.ca',
      },
    ],
    'Quebec': [
      {
        'name': 'COCQ-SIDA',
        'mapsUrl':
            'https://www.google.com/maps/dir//COCQ-SIDA+(Coalition+des+organismes+communautaires+qu%C3%A9b%C3%A9cois+de+lutte+contre+le+sida),+1+R.+Sherbrooke+E,+Montr%C3%A9al,+QC+H2X+3V8/',
        'address': '1, rue Sherbrooke Est',
        'city': 'Montréal',
        'province': 'QC',
        'postalCode': 'H2X 3V8',
        'phone': '514-844-2477',
        'email': 'info@cocqsida.ca',
      },
      {
        'name': 'GapVies',
        'mapsUrl':
            'https://www.google.com/maps/dir//Gap-Vies+Inc,+3330+Rue+Jarry+E,+Montreal,+Quebec+H1Z+2E8/',
        'address': '3330, Rue Jerry est',
        'city': 'Montréal',
        'province': 'QC',
        'postalCode': 'H1Z 2E8',
        'phone': '514-722-5655',
        'email': 'gapvies@gapvies.ca',
      },
      {
        'name': 'ACC Montréal',
        'mapsUrl':
            'https://www.google.com/maps/dir//AIDS+Community+Care+Montreal,+2075+Rue+Plessis,+Montreal,+Quebec+H2L+2Y4/',
        'address': '2075 Rue Plessis',
        'city': 'Montréal',
        'province': 'QC',
        'postalCode': 'H2L 2Y4',
        'phone': '514-527-0928',
        'email': 'info@accmontreal.org',
      },
    ],
    'Saskatchewan': [
      {
        'name': 'AIDS Programs of South Saskatchewan',
        'mapsUrl':
            'https://www.google.com/maps/dir//AIDS+Programs+South+Saskatchewan,+1325+Albert+St,+Regina,+SK+S4R+2R6/',
        'address': '1325 Albert Street',
        'city': 'Regina',
        'province': 'SK',
        'postalCode': 'S4R 2R6',
        'phone': '306-924-8420',
        'email': 'admin@apssregina.ca',
      },
      {
        'name': 'Persons Living with AIDS Network',
        'mapsUrl':
            'https://www.google.com/maps/dir//Persons+Living+With+Aids+Network+Of+Sask,+127C+Avenue+D+N,+Saskatoon,+SK+S7L+1M5/',
        'address': '127C Avenue D No',
        'city': 'Saskatoon',
        'province': 'SK',
        'postalCode': 'S7L 1M5',
        'phone': '(306) 373-7766',
        'email': 'plwa@sasktel.net',
      },
      {
        'name': 'All Nations Hope Network',
        'mapsUrl':
            'https://www.google.com/maps/dir//All+Nations+Hope+Network,+2735+5th+Ave,+Regina,+SK+S4T+0L2/',
        'address': 'P.O. Box 1328',
        'city': 'Fort Qu\'Appelle',
        'province': 'SK',
        'postalCode': 'S0G 1S0',
        'phone': '(306) 525-3698',
        'email': '',
      },
    ],
    'Ontario': [
      {
        'name': 'Black Coalition for AIDS Prevention',
        'mapsUrl':
            'https://www.google.com/maps/dir//Black+Coalition+For+AIDS+Prevention,+20+Victoria+St+4th+Floor,+Toronto,+ON+M5C+2N8/',
        'address': '20 Victoria Street',
        'city': 'Toronto',
        'province': 'ON',
        'postalCode': 'M5C 2N8',
        'phone': '416-977-9955',
        'email': 'info@black-cap.com',
      },
      {
        'name': 'Moyo Health and Community Services',
        'mapsUrl':
            'https://www.google.com/maps/dir//Moyo+Health+%26+Community+Services,+7700+Hurontario+St+%23601,+Brampton,+ON+L6Y+4M3/',
        'address': '601-7700 Hurontario Street',
        'city': 'Brampton',
        'province': 'ON',
        'postalCode': 'L6Y 4M3',
        'phone': '905-361-0523',
        'email': '',
      },
      {
        'name': 'AIDS Committee of Durham Region',
        'mapsUrl':
            'https://www.google.com/maps/dir//AIDS+Committee+of+Durham+Region,+115+Simcoe+St+S,+Oshawa,+ON+L1H+4G7/',
        'address': '115 Simcoe Street South',
        'city': 'Oshawa',
        'province': 'ON',
        'postalCode': 'L1H 4G7',
        'phone': '905-576-1445',
        'email': '',
      },
    ],
    // ... Continue adding ASO data for any additional provinces
  };

  // Launches a URL if possible, used to open maps for the location of an ASO.
  void _launchURL(String url) async {
    if (!await canLaunch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    } else {
      await launch(url);
    }
  }

  // Include ASO data for the rest of the provinces here, as shown for Alberta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.buildAppBar('My Health Locator'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Main heading for the page.
              CommonWidgets.buildMainHeading('Locate an ASO'),
              // Dropdown menu to select a province.
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: selectedProvince,
                onChanged: (newValue) {
                  setState(() {
                    selectedProvince = newValue;
                  });
                },
                items: asoDataByProvince.keys
                    .map<DropdownMenuItem<String>>((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select Province',
                  fillColor: AppColors.backgroundGreen,
                  filled: true,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Display ASO data for the selected province.
              if (selectedProvince != null)
                ...asoDataByProvince[selectedProvince]!.map((aso) {
                  String mapsUrl = aso['mapsUrl'] ??
                      ''; // Provide a default value if mapsUrl is null
                  return Card(
                    color: AppColors.backgroundGreen,
                    child: ListTile(
                      title: InkWell(
                        onTap: () {
                          if (mapsUrl.isNotEmpty) {
                            _launchURL(mapsUrl);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'No map URL available for ${aso['name']}')),
                            );
                          }
                        },
                        child: Text(
                          aso['name']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address: ${aso['address']}',
                              style: TextStyle(color: Colors.white)),
                          Text('City: ${aso['city']}',
                              style: TextStyle(color: Colors.white)),
                          Text('Province: ${aso['province']}',
                              style: TextStyle(color: Colors.white)),
                          Text('Postal Code: ${aso['postalCode']}',
                              style: TextStyle(color: Colors.white)),
                          Text('Phone: ${aso['phone']}',
                              style: TextStyle(color: Colors.white)),
                          if (aso['email']!.isNotEmpty)
                            Text('Email: ${aso['email']}',
                                style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
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
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

void main() => runApp(MaterialApp(home: LocateASOPage()));
