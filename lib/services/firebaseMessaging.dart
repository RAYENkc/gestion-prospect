import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseMessagingdemo extends StatefulWidget {
  final title = 'Notification';
  @override
  _FirebaseMessagingdemoState createState() => _FirebaseMessagingdemoState();
}

class _FirebaseMessagingdemoState extends State<FirebaseMessagingdemo> {
   final FirebaseMessaging _messaging = FirebaseMessaging();
   List<Notification > _messages;
 
   _getToken(){
          _messaging.getToken().then((token){
        print(token);
    });
  }
  
  _configFirebaseListeners(){
    _messaging.configure(
         onMessage: (Map<String,dynamic> message)async{
           print('onMessage: $message');
           _setMessage(message);
         },
         onLaunch:(Map<String,dynamic> message)async{
           print('onLaunch : $message');
           _setMessage(message);
         },
         onResume: (Map<String,dynamic> message)async{
           print('o,Resume : $message');
           _setMessage(message);
         },
    );
  }

   @override
  void initState() {
    super.initState();
    _messages = List<Notification >();
    _getToken();
    _configFirebaseListeners();
    }
  
  _setMessage(Map<String,dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'] ;
    final String body = notification['body'];
    final String mMessage = data['message'];

    setState(() {
        Notification  m = Notification (title,body,mMessage);
        _messages.add(m);
    });
 
   }
    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar : AppBar(
        title: Text(widget.title),
     ),
     body: ListView.builder(
       itemCount: null == _messages ? 0 : _messages.length,
       itemBuilder: (context, index){
         return Card(
           child: Padding(
             padding: EdgeInsets.all(15.0),
             child: Text(
               _messages[index].message,
               style: TextStyle(
                 fontSize: 16.0,
                 color : Colors.black,
               )
             ),
          
             ),
         );
       }),
    );
  }
}


class Notification {
  String title;
  String body;
  String message;
  Notification(title , body , message){
    this.title = title;
    this.body = body;
    this.message = message;
  }

}