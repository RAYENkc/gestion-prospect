import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_prospect/models/prospect.dart';
import 'package:gestion_prospect/prospect_title.dart';

import 'package:provider/provider.dart';


class ProspectList extends StatefulWidget {
  @override
  _ProspectListState createState() => _ProspectListState();
}

class _ProspectListState extends State<ProspectList> {
  @override
  Widget build(BuildContext context) {

    final prospects = Provider.of<List<Prospect>>(context);
  
    return ListView.builder(
      itemCount: prospects.length,
      itemBuilder: (context, index){
        return ProspectTitle(prospect : prospects[index]);
      },
    );
  }
}