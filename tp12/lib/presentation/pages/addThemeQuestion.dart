// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddThemeQuestion extends StatefulWidget {
  const AddThemeQuestion({Key? key}) : super(key: key);

  @override
  State<AddThemeQuestion> createState() => _AddThemeQuestion();
}

/// This is the private State class that goes with AddThemeQuestion.
class _AddThemeQuestion extends State<AddThemeQuestion> {
  final _getTheme = TextEditingController();
  bool? _answer = true;
  final _getQuestion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(
            " Quizz App",
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
                  top: 150,
                  //top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getTheme,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Nom du theme'),
                  )),
              Positioned(
                  top: 250,
                  //top: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  child: TextField(
                    controller: _getQuestion,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Question'),
                  )),
              Padding(
                //top: 100,

                padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: Text("Réponse : "),
              ),
              Padding(
                //top: 100,
                padding: EdgeInsets.fromLTRB(150, 0, 0, 20),
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
                padding: EdgeInsets.fromLTRB(250, 0, 0, 20),
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
              Positioned(
                  top: MediaQuery.of(context).size.height / 7 * 4, //top:,
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

  void pressButton(BuildContext context) {
    if (_getTheme.text != "" && _getQuestion.text != "") {
      _AddTheme(_getTheme.text);
      _addQuestion(_getTheme.text, _getQuestion.text, _answer);
      _getTheme.text = "";
      _getQuestion.text = "";
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
        content: Text("Veillez saisir un theme et une question"),
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

  Future<void> _AddTheme(String name) {
    CollectionReference themes = FirebaseFirestore.instance.collection('theme');

    // Call the user's CollectionReference to add a new user
    return themes
        .add({
          'name': name.toLowerCase(),
          'imgthm': ""
        }) // url image au lieu de "" possible
        .then((value) => print("Theme Added"))
        .catchError((error) => print("Failed to add theme: $error"));
  }

  Future<void> _addQuestion(String name, String texte, bool? _answer) {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
    return questions
        .add({
          'theme': name.toLowerCase(),
          'texte': texte.toLowerCase(),
          'answer': _answer
        })
        .then((value) => print("question Added"))
        .catchError((error) => print("Failed to add theme: $error"));
  }
}
