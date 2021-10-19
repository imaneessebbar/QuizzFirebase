import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTheme extends StatelessWidget {
  final _getTheme = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Ajouter un thème",
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    decoration: const InputDecoration(
                        fillColor: Colors.deepPurple,
                        border: OutlineInputBorder(),
                        hintText: 'Nom du theme'),
                  )),
              Positioned(
                  //top: 200,
                  top: MediaQuery.of(context).size.height / 9 * 2,
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, onPrimary: Colors.white),
                    onPressed: () => {pressButton(context)},
                    child: Text(
                      "Ajouter",
                    ),
                  ))
            ],
          ),
        ));
  }

  pressButton(BuildContext context) {
    if (_getTheme.text != "" && _getTheme.text != null) {
      _AddTheme(_getTheme.text);
      _getTheme.text = "";
      AlertDialog alert = AlertDialog(
        title: Text("Success"),
        content: Text("Ajouter avec succès! "),
        actions: [],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Champs vide"),
        content: Text("Veillez saisir un thème"),
        actions: [],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  Future<void> _AddTheme(String texte) {
    CollectionReference themes = FirebaseFirestore.instance.collection('theme');
    // Call the user's CollectionReference to add a new user
    return themes
        .add({
          'name': texte.toLowerCase(),
          'imgthm': ""
        }) // url image au lieu de "" possible
        .then((value) => print("Theme Added"))
        .catchError((error) => print("Failed to add theme: $error"));
  }
}
