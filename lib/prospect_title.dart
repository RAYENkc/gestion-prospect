import 'package:flutter/material.dart';
import 'package:gestion_prospect/models/prospect.dart';

class ProspectTitle extends StatelessWidget {

  final Prospect prospect;

  const ProspectTitle({Key key, this.prospect}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.only(top: 8.0),
     
        child: ListTile(
          title: Text(prospect.First_name),
          subtitle: Text(prospect.Mail),
        ),
    );
  }
}