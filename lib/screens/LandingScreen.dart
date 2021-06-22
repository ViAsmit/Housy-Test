import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housy_test/screens/HouseCleaningScreen.dart';
import 'package:housy_test/screens/registrationScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Position? position;
String? address;

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void _determinePositionMethod() async {
    Position? pos = await _determinePosition();
    print(pos);
    await _getAddressFromLatLng(pos);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromLatLng(Position pos) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      Placemark place = placemarks[0];
      print(place);
      setState(() {
        address = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePositionMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Services"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              "Your Location",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10.0),
            Text(address.toString()),
            SizedBox(height: 20.0),
            Text(
              "Which area of service do you need?",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HouseCleaningScreen()));
                  },
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    color: Colors.red,
                    child: Image.network(
                      "https://www.nicepng.com/png/detail/833-8334339_commercial-cleaning-cleaning-house-icons.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                    "https://cdn.iconscout.com/icon/premium/png-256-thumb/electrician-10-841696.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150.0,
                  width: 150.0,
                  color: Colors.red,
                  child: Image.network(
                    "https://www.pinclipart.com/picdir/middle/571-5710878_breakfast-tiffin-service-in-gandhi-nagar-jammu-tiffin.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                    "https://posichiro.com/wp-content/uploads/2017/02/icon-massage.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
