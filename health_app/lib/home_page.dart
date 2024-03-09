import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/appointment.dart';
import 'disease.dart';
import 'package:health_app/login.dart';
import 'package:health_app/search_city.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.city,
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
  }) : super(key: key);

  final String gender;
  final String name;
  final String email;
  final String phone;
  final String age;
  final String city;

  @override
  State<HomePage> createState() => _HomePageState();
}

TextStyle namestyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 1, 1),
      fontSize: 28,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 23,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 37, 32, 32),
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle docname() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 37, 32, 32),
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle _actionfont() {
  return GoogleFonts.ebGaramond(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

class _HomePageState extends State<HomePage> {
  late String selected_city;
  List<LoginDetails> login = [];

  @override
  void initState() {
    super.initState();
    selected_city = widget.city;
  }

  void _updateSelectedCity(String newCity) {
    setState(() {
      selected_city = newCity;
    });
  }

  var icon_pressed_drawer = false;

  Icon? new_icon;

  void iconpressed_drawer() {
    if (!icon_pressed_drawer) {
      setState(() {
        icon_pressed_drawer = true;
      });
    } else {
      setState(() {
        icon_pressed_drawer = false;
      });
    }
  }

  List<Disease> filtered_dis = [];

  List<Disease> display_dis = diseases;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 239, 239),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                splashColor: Colors.transparent,
                alignment: Alignment.center,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu_rounded,
                ),
                iconSize: 28,
                color: const Color.fromARGB(255, 255, 255, 255),
              );
            },
          ),
          title: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).push(PageTransition(
                child: SearchCity(
                    onSelect: _updateSelectedCity, finalCity: selected_city),
                type: PageTransitionType.bottomToTop,
              ));
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 138, 176, 206),
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  selected_city,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 235, 239, 240),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  width: 1.5,
                ),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Color.fromARGB(255, 246, 241, 241),
                  size: 18,
                )
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 9.0, bottom: 1.0, right: 19.0),
              child: Text('practo', style: _actionfont()),
            )
          ],
        ),
        drawer: FractionallySizedBox(
          widthFactor: 0.7,
          child: Drawer(
            child: Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 30, 8, 47),
                  child: ListTile(
                    leading: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 30, 8, 47),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: sort_child_properties_last
                      children: [
                        Row(
                          children: [
                            Text(widget.name, style: namestyle1()),
                            const SizedBox(
                              width: 35,
                            ),
                            Text(widget.gender == 'Male' ? '( M )' : '( F )',
                                style: namestyle2()),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.phone,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.age} years',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      if (notification is OverscrollIndicatorNotification) {
                        notification.disallowIndicator();
                      }
                      return false;
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: diseases.length,
                            itemBuilder: (ctx, drawerindex) {
                              void addandremfilters() {
                                setState(() {
                                  diseases[drawerindex].is_filter_added =
                                      !diseases[drawerindex].is_filter_added;
                                  if (diseases[drawerindex].is_filter_added) {
                                    filtered_dis.add(diseases[drawerindex]);
                                  } else {
                                    filtered_dis.remove(diseases[drawerindex]);
                                  }
                                  for (var disease in filtered_dis) {
                                    print(disease.dis_name);
                                  }
                                });
                              }

                              return ListTile(
                                title: Text(
                                  diseases[drawerindex].dis_name,
                                  style: _getTextStyle1(),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      diseases[drawerindex].is_not_selected =
                                          !diseases[drawerindex]
                                              .is_not_selected;
                                      addandremfilters();
                                      if (display_dis.isNotEmpty) {
                                        display_dis = filtered_dis;
                                      } else {
                                        display_dis = diseases;
                                      }
                                    });
                                  },
                                  icon: diseases[drawerindex].is_not_selected
                                      ? const Icon(
                                          Icons.toggle_off_outlined,
                                          color:
                                              Color.fromARGB(255, 72, 69, 69),
                                        )
                                      : const Icon(
                                          Icons.toggle_on_outlined,
                                          color: Colors.green,
                                        ),
                                  iconSize: 35,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              if (notification is OverscrollIndicatorNotification) {
                notification.disallowIndicator();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: display_dis.length,
              itemBuilder: (ctx, listindex) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              display_dis[listindex].dis_name,
                              style: namestyle(),
                            ),
                          ),
                          display_dis[listindex].dis_anim,
                        ],
                      ),
                      const SizedBox(height: 30),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          if (notification is OverscrollIndicatorNotification) {
                            notification.disallowIndicator();
                          }
                          return false;
                        },
                        child: Container(
                          height: 350,
                          color: const Color.fromARGB(255, 243, 239, 239),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.3 / 3.7,
                            ),
                            itemCount: display_dis[listindex].doctors.length,
                            itemBuilder: (ctx, gridindex) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        child: Appointment(
                                          doc_name: display_dis[listindex]
                                              .doctors[gridindex]
                                              .name,
                                          doc_img: display_dis[listindex]
                                              .doctors[gridindex]
                                              .img,
                                          doc_desc: display_dis[listindex]
                                              .doctors[gridindex]
                                              .description,
                                          doc_spec: display_dis[listindex]
                                              .doctors[gridindex]
                                              .specialist,
                                          doc_fees: display_dis[listindex]
                                              .doctors[gridindex]
                                              .fees,
                                        ),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color.fromARGB(
                                          255, 243, 238, 245),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          display_dis[listindex]
                                              .doctors[gridindex]
                                              .img,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          display_dis[listindex]
                                              .doctors[gridindex]
                                              .name,
                                          textAlign: TextAlign.center,
                                          style: docname(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        height: 4,
                        color: Color.fromARGB(255, 39, 35, 35),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
