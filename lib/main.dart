import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String selectLoc = "Avatar";
  List<String> locklist = [
    "Avatar",
    "The smile",
    "Captain America",
    "God father",
    "Munafik",
    "The doll 3",
    "Black Panther",
  ];
  String desc = "no record";
  var tit = "", gen = "", pos = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 34, 88),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 58, 34, 88),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Search movie",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectLoc,
              onChanged: (newValue) {
                setState(() {
                  selectLoc = newValue.toString();
                });
              },
              items: locklist.map((selectLoc) {
                return DropdownMenuItem(
                  child: Text(
                    selectLoc,
                  ),
                  value: selectLoc,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _pressMe, child: const Text("Search Movie")),
            Text(desc,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  } 

  void _pressMe() async {
    var apiid = "dd78ef64";
    var url =
        Uri.parse('https://www.omdbapi.com/?t=$selectLoc&apikey=dd78ef64');
    final response = await http.get(url);
    var rescode = response.statusCode;

    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      tit = parsedJson['Title'];
      gen = parsedJson['Genre'];
      pos = parsedJson['Poster'];

      setState(() {
        desc =
            "The movie : $tit                               Genre : $gen $pos";
      });
    } else {
      setState(
        () {
          print("No record");
        },
      );
    }
  }
}
