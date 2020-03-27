import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_prospect/models/prospect.dart';
import 'package:gestion_prospect/prospect_list.dart';
import 'package:gestion_prospect/services/database.dart';
import 'package:gestion_prospect/storeMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'prospect',
      theme: ThemeData(
        scaffoldBackgroundColor:  Colors.blue[50],
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Prospect>>.value(
      value: DatabaseService().prospect,
          child: Scaffold(
            body: Column(
              children: [
                
            Flexible(
              flex: 2,
              child: StoreMap() ,
            ),
            Flexible(
              flex: 3,
              child:  ProspectList(),
              ),
           
              ]
         
         
      ),
     ),
    );
  }
}
