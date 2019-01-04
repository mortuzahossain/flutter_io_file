import 'package:flutter/material.dart';
import 'utils/databasehelper.dart';
import 'models/user.dart';

List users;

main() async{

  var db = new DatabaseHelper();

  // Add user
//  int saveuser = await db.saveUser(new User("Kamrul","1234"));
//  print("$saveuser :User saved");

//  // List User
  users = await db.getAllUsers();
  print(users);

  runApp(new MaterialApp(
    title: "Relational Databas",
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relational Database"),
        centerTitle: true,
      ),
      body: new ListView.builder(
        itemCount: users.length,
        itemBuilder:(_,int position){
          return Card(
            child: ListTile(
              title: Text(User.fromMap(users[position]).username),
              leading: CircleAvatar(child: Text(User.fromMap(users[position]).username[0]),),
              trailing: CircleAvatar(child: Text(User.fromMap(users[position]).password,style: TextStyle(color: Colors.white),)
                ,backgroundColor: Colors.cyan,),
              onTap: (){},
            ),
          );
        },
      ),
    );
  }
}
