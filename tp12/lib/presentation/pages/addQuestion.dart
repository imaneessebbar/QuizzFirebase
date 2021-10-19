// ignore_for_file: file_names

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestion();
}

/// This is the private State class that goes with AddQuestion.
class _AddQuestion extends State<AddQuestion> {
  final _getTheme = TextEditingController();
  bool? _answer = true;

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Ajouter une Question",
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 200,
                  //top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    cursorColor: Colors.deepPurple,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Entrer la question'),
                  )),
              //Padding(
              //top: 100,
              //padding: EdgeInsets.only(
              //  top: MediaQuery.of(context).size.height / 7 * 3),
              //child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //children: [
              Padding(
                //top: 100,

                padding: EdgeInsets.fromLTRB(0, 0, 0, 230),
                child: Text("Réponse : "),
              ),
              Padding(
                //top: 100,
                padding: EdgeInsets.fromLTRB(150, 0, 0, 150),
                child: ListTile(
                  title: const Text('Vrai'),
                  leading: Radio<bool>(
                    value: true,
                    activeColor: Colors.deepPurple,
                    groupValue: _answer,
                    onChanged: (bool? value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                //top: 100,
                padding: EdgeInsets.fromLTRB(250, 0, 0, 150),
                child: ListTile(
                  title: const Text('Faux'),
                  leading: Radio<bool>(
                    value: false,
                    activeColor: Colors.deepPurple,
                    groupValue: _answer,
                    onChanged: (bool? value) {
                      setState(() {
                        _answer = value;
                      });
                    },
                  ),
                ),
              ),
              //],
              //),
              //),
              Positioned(
                  //top:,
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple, onPrimary: Colors.white),
                    onPressed: () => pressButton(context, name.toString()),
                    child: Text(
                      "Ajouter",
                    ),
                  ))
            ],
          ),
        ));
  }

  void pressButton(BuildContext context, String name) {
    if (_getTheme.text != "") {
      _addQuestion(name.toString(), _getTheme.text, _answer);
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
        content: Text("Veillez saisir une question"),
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

  Future<void> _addQuestion(String name, String texte, bool? _answer) {
    CollectionReference themes =
        FirebaseFirestore.instance.collection('questions');

    // Call the user's CollectionReference to add a new user
    return themes.add({
      'theme': name.toLowerCase(),
      'texte': texte.toLowerCase(),
      'answer': _answer
    });
  }
}
