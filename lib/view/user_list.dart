import 'package:flutter/material.dart';
import 'package:gestion_prospect/models/api_response.dart';
import 'package:gestion_prospect/models/user.dart';
import 'package:gestion_prospect/services/users_service.dart';
import 'package:gestion_prospect/view/user_delete.dart';
import 'package:gestion_prospect/view/user_modify.dart';
import 'package:get_it/get_it.dart';


class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
 UsersService get service => GetIt.I<UsersService>();
   APIResponse<List<User>,List<String>> _apiResponse;
   bool _isLoading = false;
 
 @override
  void initState() {
    _fetchUsers();
    super.initState();
  }

  _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getUsersList();
     setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list of users'),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (_) => UserModify())) 
            .then((_){
                 _fetchUsers();
              });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_){
            if(_isLoading) {
              return CircularProgressIndicator();
            }
           if(_apiResponse?.error) {
              Center(child:  Text(_apiResponse.errorMessage),);
            }

          return  ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                    context: context,
                    builder:(_) => UserDelete());
                  if( result) {
                   final deleteResult = await service.deleteUser(_apiResponse.Id[index]);
                    var message;
                    if(deleteResult != null && deleteResult.data == true){
                          message = 'The user was deleted successfully';
                    } else {
                       message = deleteResult?.errorMessage ?? 'An error occured';
                    }
                  
                   showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Done'),
                          content: Text(message),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('ok'),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              )
                          ]
                        )
                        );
                 
                  }
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft,
                ),
                ),
                  child: ListTile(
                  title:  Text(
                    _apiResponse.data[index].FirstName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(_apiResponse.data[index].email),
                  onTap: (){
                     Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => UserModify(id: _apiResponse.Id[index])))
            .then((data){
              _fetchUsers();

            });
            print(_apiResponse.Id[index]);
                  },
                ),
              );

            },
            itemCount: _apiResponse.data.length,
          );
      
          }
        )
    );
  }
}
