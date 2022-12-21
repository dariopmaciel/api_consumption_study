// import 'package:http/http.dart' as http;

// import 'dart:convert';

// Future main() async {
//   final json = await fetch();
//   print(json["id"]);
// }

// Future<Map> fetch() async {
//   var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
//   var response = await http.get(url);
//   print(response.body);

//   var json = jsonDecode(response.body);
//   return json;
// }

import 'package:api_consumption_converter_money/screen/page_one_home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json-cors&key=175a9f23");

void main() async {
  //acessando o site
  //print(response.body);
  //acessando um mapa
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);

  //print(await getData());

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

Future<Map<dynamic, dynamic>> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
