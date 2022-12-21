import 'package:api_consumption_converter_money/main.dart';
import 'package:flutter/material.dart';

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

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
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

//a criação desta função foi para minimizar a edição de texto
Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        border: const OutlineInputBorder(),
        prefixText: prefix),
    style: const TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: (value) => f,
    keyboardType: const TextInputType.numberWithOptions(),
  );
}
