import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  var _enterDataField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "File Test",
      home: Scaffold(
        appBar: AppBar(
          title: Text("HI FILE"),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("READ/Write"),
                leading: CircleAvatar(child: Icon(Icons.print),),
              ),
              
              TextField(
                controller: _enterDataField,
                decoration: InputDecoration(
                  labelText: "Write Something",
                  hintText: "Hello World"
                ),
              ),
              
              FlatButton(
                  onPressed: () async{
                    setState(() {
                      writeData(_enterDataField.text);
                    });
                  },
                  child: Text("Save Data",style: TextStyle(color: Colors.white,fontSize: 20.0),),
                color: Colors.greenAccent,
              ),

              FutureBuilder(
                future: readData(),
                builder: (BuildContext context,AsyncSnapshot<String> data){
                  if (data.hasData != null){
                    return Text(data.data.toString());
                  }
                },
              )



            ],
          ),
        ),

      ),
    );
  }

}


Future<String> get _localPath async{
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; // Home Directory
}

Future<File> get _localFile async{
  final path = await _localPath;
  return new File('$path/data.txt');
}

Future<File> writeData(String message) async {
  final file = await _localFile;
  // Writing the file
  return file.writeAsString(message);
}

// Read Data
Future<String> readData() async {
  try {
    final file = await _localFile;
    return await file.readAsString();
  } catch (e){
    debugPrint('Error: $e');
    return 'Error: $e';
  }
}