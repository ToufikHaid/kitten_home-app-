import 'package:cat_adoption/Authentifinication/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Helpers/Const.dart';
import 'Helpers/NavigatorDrawerWidget.dart';
import 'Helpers/Transition.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      drawer: NavigationDrawerWidget(),


      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
           ),
        child: Center(
          child: FlatButton(child: Text('SignOut'),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Transition()));
            },

          ),
        ),
      ),
    );
  }
}
