import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:blood_donor/config/routes/app_routes.dart';
import 'package:blood_donor/core/components/custom_dialogs.dart';
import 'package:blood_donor/core/components/custom_ripple_indecator.dart';
import 'package:blood_donor/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;



class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _controller;
  bool isMapCreated = false;
  Position? position;
  Widget? _child;
  BitmapDescriptor? bitmapImage;
  Marker? marker;
  Uint8List? markerIcon;
  var lat = [];
  var lng = [];
  String? _name;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    _child =const RippleIndicator(message:"Getting Location");
    getIcon();
    getCurrentLocation();
    super.initState();
  }

  



  void initMarker(request, requestId) {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    // creating a new MARKER
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(request['location'].latitude, request['location'].longitude),
        onTap: () async {
          CustomDialogs.progressDialog(context: context, message: 'Fetching');
          Navigator.pop(context);
          return showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 180.0,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Text(
                                request['bloodGroup'],
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              radius: 30.0,
                              backgroundColor:
                                  Color.fromARGB(1000, 221, 46, 68),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _name??'',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black87),
                              ),
                              Text(
                                "Quantity: " + request['quantity'] + " L",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black87),
                              ),
                              Text(
                                "Due Date: " + request['dueDate'],
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:12.0,right: 12.0),
                        child: Text(
                          request['address'],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              UrlLauncher.launch("tel:${request['phone']}");
                            },
                            textColor: Colors.white,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            color: Color.fromARGB(1000, 221, 46, 68),
                            child: Icon(Icons.phone),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              String message="Hello $_name, I am a potential blood donor willing to help you. Reply back if you still need blood.";
                              UrlLauncher.launch("sms:${request['phone']}?body=$message");
                            },
                            textColor: Colors.white,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            color: Color.fromARGB(1000, 221, 46, 68),
                            child: Icon(Icons.message),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
      print(markerId);
    });
  }

  void getCurrentLocation() async {
     LocationPermission permission;
         bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

   if (!serviceEnabled) {
    
        Geolocator.openLocationSettings();
   
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var res= await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });

   ;
  }

  void getIcon() async {
    markerIcon = await getBytesFromAsset('assets/images/marker2.png', 120);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Set<Marker> _createMarker() {
  //   return <Marker>[
  //     Marker(
  //       markerId: MarkerId("home"),
  //       position: LatLng(position!.latitude, position!.longitude),
  //       icon: BitmapDescriptor.fromBytes(markerIcon!),
  //     ),
  //   ].toSet();
  // }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setmapstyle(String mapStyle) {
    _controller!.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      getJsonFile('assets/customStyle.json').then(setmapstyle);
    }
    return _child!;
  }

  Widget mapWidget() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(position!.latitude, position!.longitude),
            zoom: 18.0,
          ),
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            isMapCreated = true;
            getJsonFile('assets/customStyle.json').then(setmapstyle);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              backgroundColor:const Color.fromARGB(1000, 221, 46, 68),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    Routes.bloodRequest
                    );
              },
              icon:const Icon(IconBroken.Add_User),
              label:const Text("Request Blood"),
            ),
          ),
        )
      ],
    );
  }
}
