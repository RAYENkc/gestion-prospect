import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class  StoreMap extends StatefulWidget {


  @override
  _StoreMapState createState() => _StoreMapState();
}

class _StoreMapState extends State<StoreMap> {
  GoogleMapController _controller;
  Stream<QuerySnapshot> _locationStores;
  bool mapToggle = false;
  var currentLocation;



  @override
  void initState(){
    super.initState();
       Geolocator().getCurrentPosition().then((currloc){
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
       

      });
      });
    _locationStores = Firestore.instance
    .collection('Geolocation')
    .snapshots();
    
  }

  @override
  Widget build(BuildContext context) {
   // List<DocumentSnapshot> documents;
    return Stack( 
        children: <Widget>[
            StreamBuilder<QuerySnapshot>(
        stream: _locationStores,
        builder: (context , snapshot) {
       final documents = snapshot.data.documents;
       
        

         
        return    GoogleMap(
                initialCameraPosition:  CameraPosition(
                  target: LatLng(36.5735526,10.8564992),
                  zoom: 10),
                   onMapCreated:(GoogleMapController controller) {
                       _controller = controller;
         
                       },
      markers: documents
         .map((document)=> Marker(
             markerId: MarkerId(currentLocation.toString()),
             icon: BitmapDescriptor.defaultMarker,
             position: LatLng(
               document['location'].latitude, 
               document['location'].longitude,
               ),
             /*  infoWindow: InfoWindow(
                 title: Text('bien'),
                 // document['adresss'],
                // snippet: document['address'],
               ),*/
        ),
         ).toSet(),



          );
       }
       )
         

        ],

    );
  
  }
}