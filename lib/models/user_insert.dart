
import 'package:flutter/foundation.dart';

class UserManipulation{
  String FirstName;
  String Last_name;
  String email;
  String Phone;
  String Address;
  String id;
UserManipulation({
  @required this.FirstName,
  @required  this.Last_name,
  @required  this.email,
  @required this.Phone,
  @required this.Address,
  @required this.id,
 });

 Map<String, dynamic> toJson() {
   return{
   "FirstName" : FirstName,
   "Last_name" :Last_name,
   "email" :  email,
   "Phone" : Phone,
   "Address" : Phone,
   "id" : Phone,
   };

  }

}