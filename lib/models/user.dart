

class User{
  String FirstName;
  String Last_name;
  String email;
  String Phone;
  String Address;
  String id;


 User({
   this.FirstName,
   this.Last_name,
  this.email,
  this.Phone,
  this.Address,
  this.id,
 });

/*factory User.fromJson(Map<String, dynamic > item ){
  return User(
             Phone: item['data']['Phone'],
             Address: item['data']['Address'],
             Last_name: item['data']['Last_name'],
              email: item['data']['email'],
             id: item['data']['id'],
             FirstName: item['data']['FirstName'],
             
            
             

             );

}*/
}