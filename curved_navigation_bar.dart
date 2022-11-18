import 'package:cat_adoption/Add%20Cat.dart';
import 'package:cat_adoption/ProfilPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Helpers/Const.dart';
import 'Home.dart';

class curved_navigation_bar extends StatefulWidget {
  const curved_navigation_bar(  {Key? key}) : super(key: key);

  @override
  State<curved_navigation_bar> createState() => _curved_navigation_barState();
}

class _curved_navigation_barState extends State<curved_navigation_bar> {

  GlobalKey<CurvedNavigationBarState> _NavKey = GlobalKey();

  var pagesAll = [Home(),AddCat(),ProfilPage()];

  var myindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.black87)
        ),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],),
          child: CurvedNavigationBar(
            height: 50,
            backgroundColor: PrimaryColor,
            buttonBackgroundColor: Colors.grey.shade200,
            color: Colors.grey.shade200,
            key: _NavKey,
            items: [
              Icon(FontAwesomeIcons.cat),
              Icon(FontAwesomeIcons.add),
              Icon(FontAwesomeIcons.solidUser,size: 20,),
            ],
            onTap: (index){
              setState(() {
                myindex=index;
              });

            },
          ),
        ),
      ),
      body: pagesAll[myindex],
    );
  }
}
