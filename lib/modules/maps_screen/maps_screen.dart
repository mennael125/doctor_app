import 'dart:async';

import 'package:doctorapp/shared/components/componants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
Position ? currentLocation ;
var  long ;
var lat ;

CameraPosition ? _kGooglePlex ;

  Completer<GoogleMapController> _controller = Completer();
//function to get current position
  Future getPosition() async {
    //to check permission

    LocationPermission locationPermission = await Geolocator.checkPermission();

    //to check location button is on in mobile phone or not
    bool services = await Geolocator.isLocationServiceEnabled();
    print('location button in your mobile phone is $services');
    if (services == false) {
      toast(
        text: 'Your location is off please turn on it ',
        state: ToastState.warning,
      );
    }
    if (locationPermission == LocationPermission.denied) {
      print('locationPermission is denied');
      print('========================================');

      //ask for permission
      locationPermission = await Geolocator.requestPermission();

    }
    if (locationPermission == LocationPermission.always) {
      //get current location by lat and long
      getCurrentLocation();
    }
  }

  getCurrentLocation()async {

    currentLocation= await  Geolocator.getCurrentPosition().then((value) => value);
lat=currentLocation!.latitude;
long=currentLocation!.longitude
    ;
//position in map
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 10.4746,
    );
    //to refresh page
    setState(() {

    });

  }

  @override
  void initState() {
    getPosition();
    getCurrentLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(6.0),
        child:_kGooglePlex ==null?Center(child: CircularProgressIndicator(),): Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}


