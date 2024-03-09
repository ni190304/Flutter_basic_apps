import 'dart:io';

import 'package:fav_places/img_inp.dart';
import 'package:fav_places/loc_inp.dart';
import 'package:fav_places/providernotifieradd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Addaplace extends ConsumerStatefulWidget {
  const Addaplace({super.key});

  @override
  ConsumerState<Addaplace> createState() {
    return _AddaplaceState();
  }
}

class _AddaplaceState extends ConsumerState<Addaplace> {
  final _titlecontroller = TextEditingController();
  File? _selectedImage;

  void _saveplace() {
    final enteredtext = _titlecontroller.text;

    if (enteredtext.isEmpty || _selectedImage == null) {
      return;
    }

    ref.read(userplacesprovider.notifier).add_place(enteredtext,_selectedImage!);

    Navigator.of(context).pop();
  }

  void _takepic() {}

  @override
  void dispose() {
    _titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titlecontroller,
                style: const TextStyle(color: Colors.white),
                
              ),
              const SizedBox(
                height: 16,
              ),
              ImageInput(onPickImage: (image){
                _selectedImage = image;
                

              },),
              const SizedBox(
                height: 16,
              ),

              const LocationInput(),

              const SizedBox(
                height: 16,
              ),

              ElevatedButton.icon(
                onPressed: _saveplace,
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
