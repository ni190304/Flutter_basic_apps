import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? pickedlocation;

  var isgettingloc = false;

  void _getloc() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isgettingloc = true;
    });

    locationData = await location.getLocation();

    setState(() {
      isgettingloc = false;
    });

    print(locationData.longitude);
    print(locationData.latitude);

    
  }

  @override
  Widget build(BuildContext context) {

    Widget preview_content = const Text('No location chosen');

    if(isgettingloc){
      preview_content = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            )
            
          ),
          child: Center(child: preview_content),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getloc,
                icon: const Icon(Icons.location_on_rounded),
                label: const Text('Get current location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.location_city),
                label: const Text('Select on map')),
          ],
        ),
      ],
    );
  }
}
