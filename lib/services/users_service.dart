import 'dart:convert';
import 'dart:async';

import 'package:gestion_prospect/models/api_response.dart';
import 'package:gestion_prospect/models/user.dart';
import 'package:gestion_prospect/models/user_insert.dart';
import 'package:http/http.dart' as http;
class UsersService{
  static const API = 'https://us-central1-gestion-prospect.cloudfunctions.net/webApi/api/v1';


 Future<APIResponse<List<User>,List<String>>> getUsersList() async {
   final data = await http.get(API +'/users');
   //print(data.body);
   
       if (data.statusCode == 200){
         final jsonData = json.decode(data.body);
       
           
         final users = <User>[];
         final List<String> Ids = [];
        
          for (var item in jsonData) {
             
             final user = User(
             Phone: item['data']['Phone'],
             Address: item['data']['Address'],
             Last_name: item['data']['Last_name'],
              email: item['data']['email'],
             id: item['data']['id'],
             FirstName: item['data']['FirstName'],
                                      
          );
             users.add(user);
             Ids.add(item['id']);
             print(Ids);
         }
         return APIResponse<List<User>,List<String>>(data: users , Id: Ids );
        
       }
      
       return APIResponse<List<User>,List<String>>(error:  true , errorMessage: 'An error occured');
  
   
   
  }


Future<APIResponse<User,String>> getUser(String id) async {
  
   final data = await http.get(API +'/users/'+ id);
   //print(data.body);
   
       if (data.statusCode == 200){
         final jsonData = json.decode(data.body); 
         final String Id="";
         Id: jsonData['id'];
         print(jsonData);             
         final user = User(
             Phone: jsonData['data']['Phone'],
             Address: jsonData['data']['Address'],
             Last_name: jsonData['data']['Last_name'],
              email: jsonData['data']['email'],
             id: jsonData['data']['id'],
             FirstName: jsonData['data']['FirstName'],
                         
              );
         
             
       
         return APIResponse<User,String>(data: user, Id: Id );
        
       }
      
       return APIResponse<User,String>(error:  true , errorMessage: 'An error occured');
  
   
   
  }



Future<APIResponse<bool,String>> createUser(UserManipulation item) async {
   final data = await http.post(API +'/users',body: json.encode(item.toJson()) , headers: {'Content-Type': 'application/json' });
   //print(data.body);
       if (data.statusCode == 201){
               return APIResponse<bool,String>(data: true);
       }
       return APIResponse<bool,String>(error:  true , errorMessage: 'An error occured');
  }


Future<APIResponse<bool,String>> updateUser(UserManipulation item, String id) async {
   final data = await http.put(API +'/users/'+ id,body: json.encode(item.toJson()) , headers: {'Content-Type': 'application/json' });
   //print(data.body);
       if (data.statusCode == 200){
               return APIResponse<bool,String>(data: true, Id : id);
       }
       return APIResponse<bool,String>(error:  true , errorMessage: 'An error occured');
  }



Future<APIResponse<bool,String>> deleteUser(String id) async {
   final data = await http.delete(API +'/users/'+ id , headers: {'Content-Type': 'application/json' });
   //print(data.body);
       if (data.statusCode == 204){
               return APIResponse<bool,String>(data: true, Id : id);
       }
       return APIResponse<bool,String>(error:  true , errorMessage: 'An error occured');
  }

}