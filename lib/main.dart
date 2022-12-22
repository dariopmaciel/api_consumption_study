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

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'screen/page_one_home.dart';

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

Future<Map> getData() async {
  var url = Uri.parse(
      "https://api.hgbrasil.com/finance?format=json-cors&key=175a9f23");
  var response = await http.get(url);
  //deve consumir apenas o solicitao
  //confirmação de que se está consumindo a API
  //print(response.body);
  //print(json.decode(response.body)["results"]["currencies"]["USD"]["buy"]);
  return jsonDecode(response.body);
}
