import 'package:fav_places/place.dart';
import 'package:fav_places/placedetails.dart';
import 'package:flutter/material.dart';
import 'img_inp.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
          child: Text(
        'No places added yet!',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ));
    }

    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: ListView.builder(
          itemCount: places.length,
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(places[index].image)
              ),
                  title: Text(places[index].title,
                      style: TextStyle(color: Colors.white)),
                  
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PlaceDetails(place: places[index])));
                  },
                ),
          )),
    );
  }
}
