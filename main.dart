import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchListExample(), // for seing Search and Add to  favourites;
      //home: UserList(), //for seeing data of retrieved Cities Using Api
    );
  }
}

class UserList extends StatelessWidget {
  final String apiUrl = "https://indian-cities-api-ihfclxjmcj.now.sh/cities";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body);
  }

  String _name(dynamic user) {
    return user['City'];
  }

  List cities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(_name(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    cities.add(_name(snapshot.data[index]));
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(_name(snapshot.data[index])),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
