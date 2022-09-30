import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation? _logoAnimation;
  AnimationController? _logoController;
  @override
  void initState() {
    _logoController = AnimationController(
      vsync: this,
      duration:const Duration(seconds: 2),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController!,
      curve: Curves.easeIn,
    );

    _logoAnimation!.addListener(() {
      if (_logoAnimation!.status == AnimationStatus.completed) {
        return;
      }
      setState(() {});
    });

    _logoController!.forward();
    super.initState();
    startTime();
  }

 

  Future<void> navigationPage() async {
    Navigator.pushReplacementNamed(
        context, Routes.login);
  }

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return  Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
      child: SizedBox(
        height: _logoAnimation!.value*250.0,
        width: _logoAnimation!.value*250.0,
        child: Image.asset("assets/images/logo.png"),
      ),
          )
    );
  }
}
