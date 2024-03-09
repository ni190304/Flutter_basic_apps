import 'package:fav_places/add_a_place.dart';
import 'package:fav_places/placelist.dart';
import 'package:fav_places/providernotifieradd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final userplaces = ref.watch(userplacesprovider);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Your fav places'),
        actions: [IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const Addaplace()));
        }, icon: const Icon(Icons.add_box))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: PlacesList(places: userplaces),
      ),
    );
  }
}
