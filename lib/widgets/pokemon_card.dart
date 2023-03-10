import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemonDataScreen.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;

  const PokemonCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
  }) : super(key: key);

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
        onTap: () => {
          Navigator.pushNamed(
            context,
            "/details",
            arguments: PokemonDataScreen(id, name, image),
          )
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: getContainerDecoration(),
          child: Stack(
            children: [
              //O NUMERO NO FUNDO
              Text(
                "$id",
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
                        image,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const Divider(),
                  Text(
                    "${name[0].toUpperCase()}${name.substring(1)}",
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
