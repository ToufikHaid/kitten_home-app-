import 'dart:ffi';

import 'package:cat_adoption/Add%20Cat.dart';
import 'package:cat_adoption/Helpers/NavigatorDrawerWidget.dart';
import 'package:cat_adoption/ProfilPage.dart';
import 'package:cat_adoption/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Helpers/Const.dart';
import 'DetailsScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List cats = [];

  CollectionReference catsRef = FirebaseFirestore.instance.collection('cats');

  TextEditingController textController = TextEditingController();

  getData() async {
    var responsebody =
        await FirebaseFirestore.instance.collection('cats').get();
    responsebody.docs.forEach((element) {
      setState(() {
        cats.add(element.data());
      });
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: false,
        elevation: 0.0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                FontAwesomeIcons.bars,color: PrimaryColor,size: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }
        ),
        titleSpacing: -5,


        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: PrimaryColor),
              color: Colors.white,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              width: 30,
              height: 30,
              child: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,2,0,0),
                  child: Icon(
                    FontAwesomeIcons.filter,size: 18,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: PrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find a New Friend',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child:
                  cats.isEmpty ? Center(child: Text('Empty')) :
                  ListView.builder(
                      itemCount: cats.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(110, 25, 8, 0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(18),
                                          topRight: Radius.circular(18))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        35, 15, 20, 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ("${cats[index]['name']}"),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(("${cats[index]['wilaya']}"),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.grey.shade600)),
                                          ],
                                        ),
                                        cats[index]['male']
                                            ? Icon(
                                          FontAwesomeIcons.mars,
                                                color: Colors.blueAccent,
                                                size: 25,
                                              )
                                            : Icon(
                                          FontAwesomeIcons.venus,
                                                color: Colors.pinkAccent,
                                                size: 25,
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(180)),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(180)),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage("${cats[index]['image']}"),
                                  ),
                                  width: 130,
                                  height: 130,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    description:
                                        "${cats[index]['description']}",
                                    wilaya: "${cats[index]['wilaya']}",
                                    name: "${cats[index]['name']}",
                                    image: "${cats[index]['image']}",
                                    race: "${cats[index]['race']}",
                                    age: "${cats[index]['age']}",
                                    number: "${cats[index]['number']}",
                                    userName: "${cats[index]['userName']}",
                                    male: cats[index]["male"],
                                    city: cats[index]["city"],
                                    email: "${cats[index]['email']}",
                                    uid: "${cats[index]['uid']}",
                                    docId: '${cats[index]['docId']}',
                                  ),
                                ));
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
