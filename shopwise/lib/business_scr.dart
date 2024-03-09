import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopwise/business/stock_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 33,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.zeyada(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 41,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _BusinessScreenState extends State<BusinessScreen> {
  String? user_email;
  Future<String?>? user_dp_future;

  @override
  void initState() {
    super.initState();
    user_email = FirebaseAuth.instance.currentUser!.email;
    getUserImg();
    getAllEmails(user_email!);
  }

  Future<String?> getUserImg() async {
    String imgpath = 'user-images/$user_email/$user_email.jpg';

    try {
      String user_dp_url =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_dp_url);
      });
      return user_dp_url;
    } catch (e) {
      // Handle any errors, such as the image not being available
      print('Error loading profile image: $e');
      setState(() {
        user_dp_future =
            Future.value(null); // Update the Future with null value
      });
      return null;
    }
  }

  Future<List<String>> getAllEmails(String currentUserEmail) async {
    List<String> emails = [];

    // Reference to the "Business" collection
    CollectionReference businessCollection =
        FirebaseFirestore.instance.collection('Business');

    // Query all documents in the collection
    QuerySnapshot querySnapshot = await businessCollection.get();

    // Loop through the documents and extract the email field
    querySnapshot.docs.forEach((doc) {
      String email = doc.get('email');
      if (email != null && email != currentUserEmail) {
        emails.add(email);
      }
    });

    print('Other emails are $emails');

    return emails;
  }

  Future<void> deleteitem(String itemid) async {
    DocumentReference<Map<String, dynamic>> itemref = FirebaseFirestore.instance
        .collection('ActiveBusiness')
        .doc(user_email)
        .collection('Stock') // Replace 'email' with the appropriate value
        .doc('items')
        .collection('items')
        .doc(itemid);

    try {
      await itemref.delete();
    } catch (e) {
      print('Error deleting : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        drawer: FractionallySizedBox(
          widthFactor: 0.99,
          child: Drawer(
            child: Column(
              children: [
                Container(
                  // color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, top: 10),
                    child: ListTile(
                      leading: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          leading: Builder(
            builder: (BuildContext context) {
              return Align(
                alignment:
                    Alignment.centerLeft, // Set the alignment to center-left
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 44, 43, 43),
                    child: FutureBuilder<String?>(
                      future: user_dp_future, // Use the Future here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ); // Show a loading indicator while fetching the image URL
                        } else if (snapshot.hasData && snapshot.data != null) {
                          return ClipOval(
                            child: Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              height: 39,
                              width: 39,
                            ),
                          ); // Display the image if available
                        } else {
                          return const Text(
                              '!'); // Display a message if the image is not available
                        }
                      },
                    ),
                  ),
                  iconSize: 28,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              );
            },
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Shopwise',
                  style: namestyle2(),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const StockEntry();
                    },
                  ));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                )),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('ActiveBusiness')
              .doc(user_email)
              .collection('Stock') // Replace 'email' with the appropriate value
              .doc('items')
              .collection('items')
              .snapshots(),
          builder: (context, useritems) {
            return FutureBuilder<List<String>>(
              future: getAllEmails(user_email!),
              builder: (context, otheritems) {
                if (useritems.connectionState == ConnectionState.waiting ||
                    otheritems.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (useritems.hasError) {
                  return Center(
                    child: Text('Error: ${useritems.error}'),
                  );
                }

                if (otheritems.hasError) {
                  return Center(
                    child: Text('Error: ${otheritems.error}'),
                  );
                }

                final items = useritems.data?.docs ?? [];

                final businessemails = otheritems.data ?? [];

                if (items.isEmpty && businessemails.isEmpty) {
                  return const Center(
                    child: Text('There are no items to show you.'),
                  );
                }

                // Render your UI with the list of items here
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      if (items.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Your Stock',
                                style: namestyle1(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final itemData = items[index].data();
                                  final itemid = items[index].id;

                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Dismissible(
                                          onDismissed: (direction) {
                                            deleteitem(itemid);
                                          },
                                          key: Key(itemData.toString()),
                                          direction: DismissDirection.up,

                                          background: Container(
                                            // color: Colors.red,
                                            alignment: Alignment.bottomCenter,
                                            height: 20,
                                            width: 100,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          secondaryBackground: Container(
                                            // color: Colors.red,
                                            alignment: Alignment.bottomCenter,
                                            height: 50,
                                            width: 100,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                          ),
                                          // background: Container(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                            ),
                                            width: 300,
                                            height: 225,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text(
                                                      itemData['product-name'],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      itemData['product-quan'],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    // Other UI elements based on the item data
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      deleteitem(itemid);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      if (businessemails.isNotEmpty) 
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Similar stocks',
                                style: namestyle1(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: businessemails.length,
                                itemBuilder: (context, index) {
                                  final email =
                                      businessemails[index].toString();

                                  return Column(
                                    children: [
                                      Text(email),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
