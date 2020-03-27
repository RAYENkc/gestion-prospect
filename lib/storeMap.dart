import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class StoreMap extends StatelessWidget {
 /* const StoreMap ({
    Key key,
    @required this.documents,
    @required this.initialPosition,

  }) : super(key: key);
*/
  
GoogleMapController _controller;

  
  @override
  Widget build(BuildContext context) {
    return Stack(
       children: <Widget>[
          GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(36.74750639709461, 9.968049640625004),
          
          ),
           onMapCreated:(GoogleMapController controller) {
            _controller = controller;
          },
        myLocationEnabled: true,
      /*   markers: DocumentSnapshot.map((document)=> Marker(
           markerId: MarkerId(document['prospectid']),
           icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
           position: LatLng(
             document['location'].latitude, 
             document['location'].longitude
             ),
             infoWindow: InfoWindow(
               title: document['firest_name'],
               snippet: document['address'],
             ),

         )),*/
      ),
     
       ],
    );
  }
   

}