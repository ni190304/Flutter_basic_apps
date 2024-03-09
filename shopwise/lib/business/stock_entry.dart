import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../stock_category.dart/stock.dart';

class StockEntry extends StatefulWidget {
  const StockEntry({super.key});

  @override
  State<StockEntry> createState() => _StockEntryState();
}

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.zeyada(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 38,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _StockEntryState extends State<StockEntry> {
  var selected_category = categories[Categories.edible_oils];
  var entered_name = '';
  var entered_quan = '';
  var isvalid = false;
  bool is_adding_data = false;

  final name_controller = TextEditingController();
  final quan_controller = TextEditingController();
  final email = FirebaseAuth.instance.currentUser!.email;

  File? cat_image_file;

  void pickImagecam() async {
    final catImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 80);

    if (catImage == null) {
      return;
    }

    setState(() {
      cat_image_file = File(catImage.path);
    });
  }

  void pickImagegall() async {
    final catImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 80);

    if (catImage == null) {
      return;
    }

    setState(() {
      cat_image_file = File(catImage.path);
    });
  }

  final formkey = GlobalKey<FormState>();

  void subcatdetails() async {
    final isvalid = formkey.currentState!.validate();

    if (!isvalid) {
      return;
    }

    if (cat_image_file == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a product image')),
      );
      return;
    }

    formkey.currentState!.save();

    final email = FirebaseAuth.instance.currentUser!.email;

    setState(() {
      is_adding_data = true;
    });

    try {
      final timestamp = Timestamp.now();
      final itemId = 'item${timestamp.seconds}${timestamp.nanoseconds}';

      final itimg = FirebaseStorage.instance
          .ref()
          .child('cat-images')
          .child(email!)
          .child(itemId);

      final catImages = itimg.child('$itemId.jpg');

      final uploadTask = catImages.putFile(cat_image_file!);

      await uploadTask.whenComplete(() async {
        final catImgUrl = await catImages.getDownloadURL();
        // print(catImgUrl);

        final newItemRef = FirebaseFirestore.instance
            .collection('ActiveBusiness')
            .doc(email)
            .collection('Stock') // Replace 'email' with the appropriate value
            .doc('items')
            .collection('items')
            .doc(itemId);

        await newItemRef.set({
          'category': selected_category!.title,
          'product-name': name_controller.text,
          'product-quan': quan_controller.text,
        });

        name_controller.clear();
        quan_controller.clear();

        setState(() {
          is_adding_data = false;
        });

        if (is_adding_data == false) {
          Navigator.of(context).pop();
        }
      });
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Failed. Try again')),
      );
    }
  }

  @override
  void dispose() {
    name_controller.dispose();
    quan_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                    key: formkey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.black,
                              child: cat_image_file != null
                                  ? ClipOval(
                                      child: Image.file(
                                        cat_image_file!,
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150,
                                      ),
                                    )
                                  : Lottie.asset('lib/animations/product.json',
                                      width: 120, height: 120),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton.icon(
                                onPressed: pickImagecam,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  elevation:
                                      const MaterialStatePropertyAll<double>(3),
                                ),
                                icon: Container(
                                  height: 40,
                                  width: 40,
                                  child:
                                      Lottie.asset('lib/animations/cam.json'),
                                ),
                                label: Text(
                                  'Use Camera',
                                  style: namestyle1(),
                                )),
                            const SizedBox(
                              height: 4,
                            ),
                            ElevatedButton.icon(
                                onPressed: pickImagegall,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  splashFactory: NoSplash.splashFactory,
                                  elevation:
                                      const MaterialStatePropertyAll<double>(3),
                                ),
                                icon: Container(
                                  height: 40,
                                  width: 40,
                                  child:
                                      Lottie.asset('lib/animations/gall.json'),
                                ),
                                label: Text(
                                  'Pick from gallery',
                                  style: namestyle1(),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Category',
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                          value: selected_category,
                          items: [
                            for (final cat in categories.entries)
                              DropdownMenuItem(
                                value: cat.value,
                                child: Text(cat.value.title),
                              )
                          ],
                          onChanged: (value) {
                            setState(() {
                              selected_category = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: name_controller,
                          decoration: const InputDecoration(
                            labelText: 'Product name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You can't keep the field empty";
                            }

                            if (value.contains(' ')) {
                              return 'Invalid credentials';
                            }

                            return null;
                          },
                          autocorrect: true,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.name,
                          keyboardAppearance: Brightness.dark,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: quan_controller,
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "You can't keep the field empty";
                            }

                            if (value.contains(' ')) {
                              return 'Invalid credentials';
                            }

                            return null;
                          },
                          autocorrect: true,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.number,
                          keyboardAppearance: Brightness.dark,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        is_adding_data
                            ? CircularProgressIndicator()
                            : ElevatedButton.icon(
                                onPressed: subcatdetails,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                    left: 15,
                                    right: 15,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                icon: const Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
