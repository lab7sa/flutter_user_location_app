import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(UserLocation());
}

class UserLocation extends StatefulWidget {
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {

  String _address;
  Placemark _placemark;

  @override
  Widget build(BuildContext context) {
    _getAddress();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Location App'),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text('You live in:', style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),),


              Text('$_address', style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),),
            ],
          ),
        ),
      ),
    );
  }

  Future _getAddress() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print('User Location: $position');

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    _placemark = placemarks[0];

    String city = _placemark.locality;

    String country = _placemark.country;

    setState(() {
      _address = "${city}, ${country}";
    });
  }

}
