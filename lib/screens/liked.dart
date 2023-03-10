import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/liked_card.dart';

import '../database.dart';

class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
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

  refresh() {
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
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = (width > 1000)
        ? 5
        : (width > 700)
            ? 4
            : (width > 450)
                ? 3
                : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(7),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        semanticChildCount: 250,
        childAspectRatio: 200 / 244,
        physics: const BouncingScrollPhysics(),
        children: docs
            .map(
              (pokemon) => LikedCard(
                id: pokemon["id"],
                name: pokemon["name"],
                image: pokemon["img"],
                refresh: refresh,
              ),
            )
            .toList(),
      ),
    );
  }
}
