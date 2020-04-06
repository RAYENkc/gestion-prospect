import 'package:flutter/material.dart';
import 'package:gestion_prospect/services/users_service.dart';
//import 'package:gestion_prospect/services/firebaseMessaging.dart';
import 'package:gestion_prospect/view/user_list.dart';
import 'package:get_it/get_it.dart';


void setupLocator(){
 GetIt.I.registerLazySingleton(() => UsersService());

 
}

void main() {
  setupLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'prospect',
      theme: ThemeData(
       // scaffoldBackgroundColor:  Colors.pink[50],
      ),
      //home: FirebaseMessagingdemo(),
      home: UserList(),
  
    );
  }
}
