import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cat_adoption/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Helpers/Const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cross_file_image/cross_file_image.dart';

import 'Home.dart';

class AddCat extends StatefulWidget {
  const AddCat({Key? key}) : super(key: key);

  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _ageTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController _numberTextController = TextEditingController();
  TextEditingController _cityTextController = TextEditingController();
  TextEditingController _raceTextController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;

  CollectionReference cats = FirebaseFirestore.instance.collection('cats');

  XFile? image;
  late String imgUrl;

  String genderdropdownValue = 'Male';
  String wilayadropdownValue = 'Adrar';

  Future getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: InkWell(
                    onTap: () => getImage(),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: image == null
                            ? CircleAvatar(
                                backgroundColor: PrimaryColor,
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 50,
                                  color: Colors.white,
                                ))
                            : Image(
                                image: XFileImage(image!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameTextController,
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "give your cat a name";
                                } else if (value.length < 3) {
                                  return 'come on give it a longer name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _ageTextController,
                              decoration: InputDecoration(
                                hintText: "Age",
                                suffixText: "months",
                                suffixStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade400),
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "give us your cat's age";
                                } else if (value.length > 3) {
                                  return 'your cat is probably younger';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  FontAwesomeIcons.arrowDown,
                                  color: Colors.black54,
                                  size: 16,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black54),
                              underline: Container(
                                  height: 1, color: Colors.grey.shade500),
                              value: genderdropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  genderdropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _raceTextController,
                              decoration: InputDecoration(
                                  hintText: 'Race',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54)),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-z]")),
                              ],
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "give us your cat's race";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  FontAwesomeIcons.arrowDown,
                                  color: Colors.black54,
                                  size: 16,
                                ),
                              ),
                              style: const TextStyle(color: Colors.black54),
                              underline: Container(
                                  height: 1, color: Colors.grey.shade500),
                              value: wilayadropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  wilayadropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Adrar',
                                'Chlef',
                                'Laghouat',
                                'Oum El Bouaghi',
                                'Batna',
                                'Béjaïa',
                                'Biskra',
                                'Béchar',
                                'Blida',
                                'Bouïra',
                                'Tamanrasset',
                                'Tébessa',
                                'Tlemcen',
                                'Tiaret',
                                'Tizi Ouzou',
                                'Algiers',
                                'Djelfa',
                                'Jijel',
                                'Sétif',
                                'Saïda',
                                'Skikda',
                                'Sidi Bel Abbès',
                                'Annaba',
                                'Guelma',
                                'Constantine',
                                'Médéa',
                                'Mostaganem',
                                "M'Sila'",
                                'Mascara',
                                'Ouargla',
                                'Oran',
                                'El Bayadh',
                                'Illizi',
                                'Bordj Bou Arréridj',
                                'Boumerdès',
                                'El Tarf',
                                'Tindouf',
                                'Tissemsilt',
                                'El Oued',
                                'Khenchela',
                                'Souk Ahras',
                                'Tipaza',
                                'Mila',
                                'Aïn Defla',
                                'Naâma',
                                'Aïn Témouchent',
                                'Ghardaïa',
                                'Relizane',
                                "El M'Ghair",
                                'El Menia',
                                'Ouled Djellal',
                                'Bordj Baji Mokhtar',
                                'Béni Abbès',
                                'Timimoun',
                                'Touggourt',
                                'Djanet',
                                'In Salah',
                                'In Guezzam',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            child: TextFormField(
                              controller: _cityTextController,
                              decoration: InputDecoration(
                                  hintText: 'City',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54)),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-z]")),
                              ],
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "what is your city";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _descriptionTextController,
                        decoration: InputDecoration(
                            hintText: 'Descreption',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Colors.black54)),
                        maxLength: 150,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return "write something about your cat";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _numberTextController,
                        decoration: InputDecoration(
                            hintText: 'Contact Number',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Colors.black54)),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "we need a number to contact you";
                          } else if (value.length != 10) {
                            return "give us a valide number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            if (image == null) {
                              Fluttertoast.showToast(
                                  msg: 'please add an image');
                            } else {
                              addCat();
                            }
                          },
                          child: Text(
                            "Add your cat",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(PrimaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addCat() async {
    CollectionReference cats = FirebaseFirestore.instance.collection("cats");

    String uemail = FirebaseAuth.instance.currentUser!.email.toString();
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();

    var storageImage = FirebaseStorage.instance.ref().child(image!.path);
    var task = storageImage.putFile(File(image!.path));

    imgUrl = await (await task).ref.getDownloadURL();

    final Catdocument = cats.doc();

    await Catdocument.set({
      'image': imgUrl,
      'uid': uid,
      'email': uemail,
      'name': _nameTextController.text,
      'race': _raceTextController.text,
      'age': _ageTextController.text,
      'wilaya': wilayadropdownValue,
      'city': _cityTextController.text,
      'description': _descriptionTextController.text,
      'number': _numberTextController.text,
      'docId': Catdocument.id,
      'date': Timestamp.now(),
      'male': genderdropdownValue == 'Male' ? true : false,
    }).then((value) => AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          //title: 'Dialog Title',
          desc: 'Your cat has been added',
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => curved_navigation_bar()));
          },
        )..show().catchError((error) => print("Failed to add user: $error")));
  }
}
