import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/PokemonModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  capturar(Pokemon p) {
    firestore.collection("liked-pokemons").doc(p.id.toString()).set({"id": p.id, "name": p.name, "img": p.img}).then(
        (e) =>
            print('Pokemon added'));
  }

  // Future<void> editar(String id, Contato c) async {
  //   //print("id -----> $id");
  //   final contato = <String, dynamic>{
  //     "nome": c.nome,
  //     "email": c.email,
  //     "telefone": c.telefone
  //   };
  //   try {
  //     await firestore.collection("contatos").doc(id).update(contato);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  excluir(String id) {
    firestore.collection("liked-pokemons").doc(id).delete().then(
        (e) =>
            print('Pokemon deleted')).catchError((err) {print(err);});
  }

  Future<List> listar() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('liked-pokemons').orderBy("id").get();
      print(querySnapshot);
      if (querySnapshot.docs.isNotEmpty) {
        docs = querySnapshot.docs.map((e) => e.data()).toList();
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }
}
