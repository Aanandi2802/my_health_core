// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:my_health_core/pages/forget_password_page.dart';
import 'package:my_health_core/pages/home_page.dart';
import 'package:my_health_core/pages/login_page.dart';
import 'package:my_health_core/pages/signup_page.dart';

//Main Featured Pages
import 'package:my_health_core/pages/my_health_education_page.dart';
import 'package:my_health_core/pages/my_health_connect_page.dart';
import 'package:my_health_core/pages/my_health_locator_page.dart';
import 'package:my_health_core/pages/my_health_tracker_page.dart';

//MyHealthConnect
import 'package:my_health_core/pages/MyHealthConnect/chat_page.dart';
import 'package:my_health_core/pages/MyHealthConnect/select_provider_page.dart';
import 'package:my_health_core/pages/MyHealthConnect/main_chat_with_service_provider_page.dart';
import 'package:my_health_core/pages/MyHealthConnect/main_chat_with_peer_page.dart';
import 'package:my_health_core/pages/MyHealthConnect/main_community_stories_page.dart';

//MyHealthLocator
import 'package:my_health_core/pages/MyHealthLocator/locate_aso_page.dart';
import 'package:my_health_core/pages/MyHealthLocator/locate_community_based_organisation_page.dart';
import 'package:my_health_core/pages/MyHealthLocator/locate_hiv_test_page.dart';
import 'package:my_health_core/pages/MyHealthLocator/locate_prep_clinic_page.dart';

//MyHealthTracker
import 'package:my_health_core/pages/MyHealthTracker/test_tracker_page.dart';
import 'package:my_health_core/pages/MyHealthTracker/appointment_tracker_page.dart';
import 'package:my_health_core/pages/MyHealthTracker/medication_tracker_page.dart';
import 'package:my_health_core/pages/MyHealthTracker/symptom_tracker_page.dart';
import 'package:my_health_core/pages/MyHealthTracker/mentalhealth_tracker_page.dart';
import 'package:my_health_core/pages/MyHealthTracker/mentalhealth_journal_page.dart';

//MyHealthEducation
import 'package:my_health_core/pages/MyHealthEducation/hiv_101_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/testing_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/prevention_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/prep_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/treatment_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/how_tos_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/open_core_quiz_page.dart';
//less priority
import 'package:my_health_core/pages/MyHealthEducation/hiv_and_ageing_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/hiv_and_disability_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/hiv_and_pregnancy_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/hiv_care_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/hiv_disclosure_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/hiv_stigma_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/sdoh_and_hiv_page.dart';
import 'package:my_health_core/pages/MyHealthEducation/sexual_health_page.dart';
import 'package:my_health_core/pages/profile_page.dart';
import 'package:my_health_core/pages/saved_page.dart';
import 'package:my_health_core/styles/app_colors.dart';

/// This is the entry point of the MyHealthCore application.
/// It sets up the MaterialApp and defines all the navigation routes.
/// Each page in the application is accessed through named routes,
/// which are mapped to the respective page widgets here.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily:
            'Poppins', // Sets the global font family for the application.
        scaffoldBackgroundColor: AppColors
            .background, // Sets the default background color for all screens.
      ),
      initialRoute: '/', // The entry point route of the application.
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/saved': (context) => SavedPage(),
        '/profile': (context) => ProfilePage(),
        '/signup': (context) => SignUpPage(),
        '/forget_password': (context) => ForgetPasswordPage(),

        '/my_health_education': (context) => MyHealthEducationPage(),
        '/my_health_connect': (context) => MyHealthConnectPage(),
        '/my_health_locator': (context) => MyHealthLocatorPage(),
        '/my_health_tracker': (context) => MyHealthTrackerPage(),

        //my-health-education
        '/hiv_101': (context) => HIV101Page(),
        '/testing': (context) => TestingPage(),
        '/prevention': (context) => PreventionPage(),
        '/prep': (context) => PrePPage(),
        '/treatment': (context) => TreatmentPage(),
        '/how_tos': (context) => HowTosPage(),
        '/open_core_quiz': (context) => OpenCoreQuizPage(),
        '/hiv_disclosure': (context) => HIVDisclosurePage(),
        '/hiv_and_ageing': (context) => HIVAndAgeingPage(),
        '/hiv_and_disability': (context) => HIVAndDisabilityPage(),
        '/hiv_and_pregnancy': (context) => HIVAndPregnancyPage(),
        '/hiv_stigma': (context) => HIVStigmaPage(),
        '/sexual_health': (context) => SexualHealthPage(),
        '/sdoh_and_hiv': (context) => SDOHAndHIVPage(),
        '/hiv_care': (context) => HIVCarePage(),

        //my-health-connect
        '/main_community_stories': (context) => MainCommunityStoriesPage(),
        '/main_chat_with_service_provider': (context) =>
            MainChatWithServiceProviderPage(),
        '/main_chat_with_peer': (context) => MainChatWithPeerPage(),
        '/chat_with_service_provider': (context) => ChatPage(),
        '/select_a_service_provider': (context) => SelectProviderPage(),

        //my-health-locator
        '/locate_aso': (context) => LocateASOPage(),
        '/locate_hiv_test': (context) => LocateHIVTestPage(),
        '/locate_prep_clinic': (context) => LocatePrepClinicPage(),
        '/locate_community_based_organisation': (context) =>
            LocateCommunityBasedOrganisationPage(),

        //my-health-locator
        '/test_tracker': (context) => TestTrackerPage(),
        '/medication_tracker': (context) => MedicationTrackerPage(),
        '/appointment_tracker': (context) => AppointmentTrackerPage(),
        '/symptom_tracker': (context) => SymptomTrackerPage(),
        '/mentalhealth_tracker': (context) => MentalHealthTrackerPage(),
        '/mentalhealth_journal': (context) => MentalHealthJournalPage(),
        // Add routes for other pages similarly
      },
    );
  }
}
