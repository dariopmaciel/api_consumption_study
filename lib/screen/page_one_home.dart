import 'package:api_consumption_converter_money/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final realController = TextEditingController();

  late double dolar;
  late double euro;

  _dolarChanged(String text) {
    print(text);
  }

  _euroChanged(String text) {
    print(text);
  }

  _realChanged(String text) {
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Conversor de moedas \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      drawer: const Drawer(),
      //utilizando future builder,
      //enquanto estiver 'obtendo dados', aparece 'carregando dados'
      //depois será mostrado a tela normal
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  "CARREGANDO DADOS...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "ERRO AO CARREGAR DADOS :-(",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                //dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                //return Container(color: Colors.green);
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      buildTextField(
                          "Dolar", "U\$ ", dolarController, _dolarChanged),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: "Dolar",
                      //     labelStyle: TextStyle(color: Colors.amber),
                      //     border: OutlineInputBorder(),
                      //     prefixText: "US \$",
                      //   ),
                      //   style: TextStyle(color: Colors.amber, fontSize: 25),
                      // ),
                      const Divider(),
                      buildTextField(
                          "Euro", "€\$ ", euroController, _euroChanged),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: "Euro",
                      //     labelStyle: TextStyle(color: Colors.amber),
                      //     border: OutlineInputBorder(),
                      //     prefixText: "€ \$",
                      //   ),
                      //   style: TextStyle(color: Colors.amber, fontSize: 25),
                      // ),
                      const Divider(),
                      buildTextField(
                          "Real", "R\$ ", realController, _realChanged),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     labelText: "Reais",
                      //     labelStyle: TextStyle(color: Colors.amber),
                      //     border: OutlineInputBorder(),
                      //     prefixText: "R \$",
                      //   ),
                      //   style: TextStyle(color: Colors.amber, fontSize: 25),
                      // ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController controle, Function fun) {
  return TextField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
      prefixText: prefix,
    ),
    controller: controle,
    style: const TextStyle(color: Colors.amber, fontSize: 25),
    onChanged: (value) => fun,
  );
}
