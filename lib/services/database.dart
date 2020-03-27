import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_prospect/models/prospect.dart';


class DatabaseService{


  //collection reference
  final CollectionReference prospectCollection = Firestore.instance.collection('prospect');


 //brew list from snapshot
 List<Prospect> _prospectListFromSnapshot(QuerySnapshot snapshot){
   return snapshot.documents.map((doc){
     return Prospect(
        doc.data['Last_name'] ?? '',
       doc.data['First_name'] ?? '',  
       doc.data['Phone'] ?? '', 
       doc.data['Mail'] ?? '', 
       doc.data['Address'] ?? '', 
       doc.data['Social_reason'] ?? '',
       doc.data['Activity'] ?? '',  
     );
   }).toList();
 }
  //get prospect stream
  Stream<List<Prospect>> get prospect {
    return prospectCollection.snapshots()
    .map(_prospectListFromSnapshot);  
    }
}