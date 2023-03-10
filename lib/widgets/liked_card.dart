import 'package:flutter/material.dart';

import '../database.dart';

class LikedCard extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final Function refresh;

  LikedCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.refresh,
  }) : super(key: key);

  @override
  State<LikedCard> createState() => _LikedCardState();
}

class _LikedCardState extends State<LikedCard> {
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
    // TODO: implement initState
    super.initState();
    initialise();
  }

  BoxDecoration getContainerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.24),
          width: 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        enableFeedback: true,
        splashColor: Colors.red[50],
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: getContainerDecoration(),
          child: Stack(
            children: [
              //O NUMERO NO FUNDO
              Text(
                "${widget.id}",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              //COLUNA COM IMAGEM DEPOIS O DIVISOR E O NOME DEPOIS
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(11),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const Divider(),
                  Text(
                    "${widget.name[0].toUpperCase()}${widget.name.substring(1)}",
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                      color: Colors.red,
                      onPressed: (() {
                        db.excluir(widget.id.toString());
                        widget.refresh();
                      }),
                      icon: const Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
