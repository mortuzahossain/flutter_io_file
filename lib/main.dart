import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'utils/databasehelper.dart';
import 'models/user.dart';


main() async{

  var db = new DatabaseHelper();

  // Add user
  int saveuser = await db.saveUser(new User("Kamrul","1234"));
  print("$saveuser :User saved");

//  // List User
  List users = await db.getAllUsers();
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

    );
  }
}
