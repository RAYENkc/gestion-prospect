import 'package:flutter/material.dart';
import 'package:gestion_prospect/models/user.dart';
import 'package:gestion_prospect/models/user_insert.dart';
import 'package:gestion_prospect/services/users_service.dart';
import 'package:get_it/get_it.dart';

class UserModify extends StatefulWidget {


  final String id;
  UserModify({this.id});

  @override
  _UserModifyState createState() => _UserModifyState();
}

class _UserModifyState extends State<UserModify> {
  bool get isEditing => widget.id != null;
  UsersService get usersService => GetIt.I<UsersService>();
 

  String errorMessage;
  User user;
  
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _PhoneController = TextEditingController();
  TextEditingController _AddressController = TextEditingController();
  TextEditingController _idController = TextEditingController();


  bool _isLoading = false;
  @override
  void initState() {
   super.initState();

    if(isEditing) {
       setState(() {
      _isLoading = true;
    });

    usersService.getUser(widget.id)
    .then((response){
       setState(() {
      _isLoading = false;
    });
      if(response.error) {
        errorMessage = response.errorMessage ?? 'An error occured';
      }
      user = response.data;
      print(user);
      _firstNameController.text = user.FirstName;
      _lastNameController.text = user.Last_name;
      _emailController.text  = user.email;
      _PhoneController.text = user.Phone;
      _AddressController.text = user.Address;
      _idController.text = user.id;
    });

    }
   
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ?  'Edit note' : 'Create users' ),),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading ? Center(child: CircularProgressIndicator() ): Column(
            children: <Widget>[
                TextField(
                  controller: _firstNameController,
                 decoration: InputDecoration(
                   hintText: 'User FirstName',
                 ),
                ),
                Container(height: 10),
                TextField(
                  controller:  _lastNameController,
                   decoration: InputDecoration(
                   hintText: 'User Last_name',
                 ),
                ),
                 Container(height: 10),
                TextField(
                controller:  _emailController,
                 decoration: InputDecoration(
                   hintText: 'User email',
                 ),
                ),
                 Container(height: 10),
                TextField(
                 controller:  _PhoneController,
                 decoration: InputDecoration(
                   hintText: 'User Phone',
                 ),
                ),
                 Container(height: 10),
                TextField(
                controller:  _AddressController,
                 decoration: InputDecoration(
                   hintText: 'User Address',
                 ),
                ),
                 Container(height: 10),
                TextField(
                 controller:  _idController,
                 decoration: InputDecoration(
                   hintText: 'User id',
                 ),
                ),
                
                Container(height: 20),
                //valide button
                SizedBox(
                  width:double.infinity,
                  height: 35,
                   child: RaisedButton(
                    child: Text("Valide"),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if(isEditing) {
                        //update user in api
                            setState(() {
                             _isLoading = true;
                            });
                        final user = UserManipulation(
                             Last_name:  _firstNameController.text,
                             FirstName: _lastNameController.text,
                             email:  _emailController.text  ,
                             Phone:  _PhoneController.text ,
                             Address: _AddressController.text,
                             id: _idController.text,
                        );
                      final result = await  usersService.updateUser(user,widget.id);

                        setState(() {
                             _isLoading = false;
                            });

                      final title = 'Done';
                      final text = result.error ? (result.errorMessage ?? 'An erreur occurred') : 'Your user was updated';

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('ok'),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              )
                          ]

                        )
                      )
                      .then((data){
                        if(result.data) {
                          Navigator.of(context).pop();
                        }

                      });

                      }else{
                        //create user in api
                           
                             setState(() {
                             _isLoading = true;
                            });
                        final user = UserManipulation(
                             Last_name:  _firstNameController.text,
                             FirstName: _lastNameController.text,
                             email:  _emailController.text  ,
                             Phone:  _PhoneController.text ,
                             Address: _AddressController.text,
                             id: _idController.text,
                        );
                      final result = await  usersService.createUser(user);

                        setState(() {
                             _isLoading = false;
                            });

                      final title = 'Done';
                      final text = result.error ? (result.errorMessage ?? 'An erreur occurred') : 'Your user was created';

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('ok'),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              )
                          ]

                        )
                      )
                      .then((data){
                        if(result.data) {
                          Navigator.of(context).pop();
                        }

                      });
                      }

                     
                    }),
                )
            ],
          ),
        ),
      
    );
  }
}