import 'dart:collection';

import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:blood_donor/core/components/customWaveIndicator.dart';
import 'package:blood_donor/core/utils/icon_broken.dart';
import 'package:blood_donor/modules/home/map_view_screen.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name, _bloodgrp, _email;
  Widget? _child;

 
 

  @override
  void initState() {
    // _child =const WaveIndicator();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      systemNavigationBarColor: Colors.black, 
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return _child?? Scaffold(
      backgroundColor:const Color.fromARGB(1000, 221, 46, 68),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:const Text(
          "Home",
          style: TextStyle(
            fontSize: 60.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration:const BoxDecoration(
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              accountName: Text(
                _name??'jjjjjjj',
                style:const TextStyle(
                  fontSize: 22.0,
                ),
              ),
              accountEmail: Text( _email??''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _bloodgrp??'',
                  style:const TextStyle(
                    fontSize: 30.0,
                    color: Colors.black54,
                    fontFamily: 'SouthernAire',
                  ),
                ),
              ),
            ),
            ListTile(
              title:const Text("Home"),
              leading:const Icon(
                IconBroken.Home,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              title:const Text("Blood Donors"),
              leading:const Icon(
                Icons.handshake_rounded,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.pushNamed(context,
                 Routes.donor);
              },
            ),
            ListTile(
              title:const Text("Blood Requests"),
              leading:const Icon(
                IconBroken.Add_User,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                //
              },
            ),
            ListTile(
              title:const Text("Campaigns"),
              leading: const Icon(
                IconBroken.Category,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () {
                Navigator.pushNamed(context,
                   Routes.campaign);
              },
            ),
            ListTile(
              title:const Text("Logout"),
              leading:const Icon(
                IconBroken.Logout,
                color: Color.fromARGB(1000, 221, 46, 68),
              ),
              onTap: () async {
                
                Navigator.pushReplacementNamed(
                    context,
                  Routes.login);
              },
            ),
          ],
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft:  Radius.circular(40.0),
            topRight:  Radius.circular(40.0)),
        child: Container(
          height: 800.0,
          width: double.infinity,
          color: Colors.white,
          child: const MapViewScreen(),
        ),
      ),
    );
  }
 
  
}
