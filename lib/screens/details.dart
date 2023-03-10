import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/models/PokemonModel.dart';
import 'package:flutter_application_1/models/pokemonDataScreen.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Database db;
  List docs = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.listar().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as PokemonDataScreen;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //IMAGEM
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                ),
                color: Colors.black,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 500,
                        width: 500,
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Image.network(
                        arguments.image,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ),
              //
              Chip(
                backgroundColor: Colors.white,
                label: Text(
                  "${arguments.name[0].toUpperCase()}${arguments.name.substring(1)}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                avatar: CircleAvatar(
                  child: Text(
                    arguments.id.toString(),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: 100,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20))),
                        onPressed: () {
                          db.capturar(Pokemon(
                              arguments.id, arguments.name, arguments.image));
                        },
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.add),
                              Text('Adicionar')
                            ])),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pop(context),
          tooltip: 'Share',
          label: const Text(
            "Back",
          ),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ));
  }
}
