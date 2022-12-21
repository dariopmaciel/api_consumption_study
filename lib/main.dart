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

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json-cors&key=175a9f23");

void main() async {
  http.Response response = await http.get(request);
  print(response.body);
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);

  runApp(MaterialApp(
    home: Container(),
  ));
}
