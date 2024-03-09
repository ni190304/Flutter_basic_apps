import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCity extends StatefulWidget {
  const SearchCity({Key? key, required this.onSelect, required this.finalCity})
      : super(key: key);

  final void Function(String updatedCity) onSelect;
  final String finalCity;

  @override
  // ignore: library_private_types_in_public_api
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  List<String> cities = [
    'Mumbai',
    'Amritsar',
    'Bangalore',
    'Vadodara',
    'Bhopal',
    'Vizag',
    'Kolkata',
    'Nagpur',
    'Delhi',
    'Lucknow',
    'Kochi',
    'Srinagar',
    'Ranchi',
    'Nashik',
    'Patna',
    'Pune'
  ];

  List<String> filteredCities = [];

  bool isLoadingCities = false;

  void updateSearchResults(String query) {
    setState(() {
      isLoadingCities = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        filteredCities = cities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
        isLoadingCities = false;
      });
    });
  }

  void updateCityData(String cityName) async {
    final url = Uri.https(
      'myhealthapp-dc787-default-rtdb.firebaseio.com',
      'user-info.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Iterate over all nodes and update the city
      data.forEach((key, value) async {
        // Update the city value
        value['personal-info']['city'] = cityName;

        // Construct the URL for the specific node
        final nodeUrl = Uri.https(
          'myhealthapp-dc787-default-rtdb.firebaseio.com',
          'user-info/$key.json',
        );

        // Convert the data to JSON
        String jsonData = jsonEncode(value);

        // Make the PATCH request to update the city for each node
        final cityResponse = await http.put(nodeUrl,
            headers: {'Content-Type': 'application/json'}, body: jsonData);

        if (cityResponse.statusCode == 200) {
          print('City updated successfully for node $key');
        } else {
          print(
              'Failed to update city for node $key. Status code: ${cityResponse.statusCode}');
        }
      });
    } else {
      print(
          'Error retrieving data from the database. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (isLoadingCities) {
      content = const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 42, 41, 41),
            strokeWidth: 1,
          ),
        ),
      );
    } else {
      content = ListView.builder(
        itemCount:
            filteredCities.isNotEmpty ? filteredCities.length : cities.length,
        itemBuilder: (ctx, index) {
          final cityName =
              filteredCities.isNotEmpty ? filteredCities[index] : cities[index];
          return ListTile(
            title: Text(cityName),
            onTap: () {
              widget.onSelect(cityName);
              updateCityData(cityName);
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 239, 239),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel, size: 24, color: Colors.black),
        ),
        title: TextField(
          onChanged: updateSearchResults,
          decoration: const InputDecoration(
            hintText: 'Search for cities...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: content,
    );
  }
}
