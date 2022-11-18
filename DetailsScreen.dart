import 'package:cat_adoption/curved_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

import 'Helpers/Const.dart';

import 'package:clipboard/clipboard.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final String race;
  final String age;
  final String wilaya;
  final String description;
  final String number;
  final String userName;
  final bool male;
  final String city;
  final String email;
  final String uid;
  final String docId;


  const DetailsScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.race,
    required this.age,
    required this.wilaya,
    required this.description,
    required this.number,
    required this.userName,
    required this.male,
    required this.city,
    required this.email,
    required this.uid, required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  )),
              child: SafeArea(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.orange,
                            )),
                      ),
                      Builder(builder: (context) {
                        if (FirebaseAuth.instance.currentUser!.uid == uid) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 3, 8),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.xmarkCircle,
                                color: Colors.red.shade400,
                              ),
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.NO_HEADER,
                                  animType: AnimType.SCALE,
                                  //title: 'Dialog Title',
                                  desc:
                                  'Are you sure you want to delete this post ?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    DeletePost(docId);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (context) => curved_navigation_bar()));
                                  },
                                )
                                  ..show();
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.435, right: 18, left: 18),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.16,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: PrimaryColor),
                              ),
                              male
                                  ? Icon(
                                FontAwesomeIcons.mars,
                                color: Colors.blueAccent,
                                size: 18,

                              )
                                  : Icon(
                                FontAwesomeIcons.venus,
                                color: Colors.pinkAccent,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                race,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                              Text(
                                age + ' months old',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: Colors.grey.shade700,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                city + ' , ' + wilaya,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                child: CircleAvatar(
                                  backgroundImage:
                                  AssetImage("Assets/Images/profil.png"),
                                ),
                                width: 75,
                                height: 75,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "Owner",
                                    style:
                                    TextStyle(color: Colors.grey.shade700),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: Text(
                              description,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 75, 0),
          child: Container(
            height: size.height * 0.05,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            child: ElevatedButton(
              onPressed: () {
                FlutterClipboard.copy(number).then((value) =>
                    Fluttertoast.showToast(
                        msg: 'Copied',
                        gravity: ToastGravity.TOP,
                        backgroundColor: PrimaryColor,
                        fontSize: 16));
              },
              child: Text(
                "Copy phone number !",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(PrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

DeletePost(docId) async {
  return FirebaseFirestore.instance
      .collection('cats')
      .doc(docId)
      .delete()
      .then((value) =>
      Fluttertoast.showToast(msg: 'Post Deleted')
          .catchError((error) => print("Failed to delete user: $error")));
}

