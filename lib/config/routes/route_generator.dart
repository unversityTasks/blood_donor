
import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:blood_donor/modules/auth/login.dart';
import 'package:blood_donor/modules/auth/register.dart';
import 'package:blood_donor/modules/blood/blood_request.dart';
import 'package:blood_donor/modules/campaigns/campaigns.dart';
import 'package:blood_donor/modules/donors/donors.dart';
import 'package:blood_donor/modules/home/home_screen.dart';
import 'package:blood_donor/modules/profile/profile.dart';
import 'package:blood_donor/modules/welcome_screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
        case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
         case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
         case Routes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
         case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
         case Routes.bloodRequest:
        return MaterialPageRoute(builder: (context) => const BloodRequestScreen());
         case Routes.donor:
        return MaterialPageRoute(builder: (context) => const DonorsScreen());
         case Routes.campaign:
        return MaterialPageRoute(builder: (context) => const CampaignScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => Scaffold(body: Container()));
  }
}
