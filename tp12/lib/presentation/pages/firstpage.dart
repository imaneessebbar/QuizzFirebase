import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp12/presentation/pages/addQuestion.dart';
import 'package:tp12/presentation/pages/addTheme.dart';
import 'package:tp12/presentation/pages/addThemeQuestion.dart';
import 'package:tp12/presentation/pages/PickThemeQuizz.dart';
import 'package:tp12/presentation/pages/quizzpage.dart';
import 'package:tp12/presentation/widgets/PickTheme.dart';

import '/data/models/question.dart';
import 'formpage.dart';

class FirstPage extends StatefulWidget {
  String title;
  FirstPage({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  _FirstPage createState() => _FirstPage();
}

CollectionReference themes = FirebaseFirestore.instance.collection("theme");

class _FirstPage extends State<FirstPage> {
  bool isvisble = false;

  bool isvisble2 = true;

  void _visible() {
    setState(() {
      isvisble = !isvisble;
    });
  }

  void _visible2() {
    setState(() {
      isvisble2 = !isvisble2;
    });
  }

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
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width / 4 * 3,
              height: 50,
              top: 50,
              child: Visibility(
                visible: true,
                child: ElevatedButton(
                  onPressed: () => quizzall(),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, onPrimary: Colors.white),
                  child: const Text('Passer un quizz'),
                ),
              ),
            ),
            Visibility(
                visible: isvisble2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4 * 3,
                      top: 150,
                      child: ElevatedButton(
                        onPressed: () => {
                          _visible(),
                        }, //ajouter les choix des themes
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white),
                        child: const Text('Ajouter un thème/question'),
                      ),
                    ),
                    Positioned(
                        top: 250,
                        width: MediaQuery.of(context).size.width / 4 * 3,
                        height: MediaQuery.of(context).size.height,
                        child: Visibility(
                          visible: isvisble,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddTheme(),
                                        settings: RouteSettings(),
                                      ),
                                    ); //formpage avec un champs theme
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.deepPurple),
                                  child: const Text('Ajouter un thème'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PickTheme(),
                                        settings: RouteSettings(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.deepPurple),
                                  child: const Text('Ajouter une question'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddThemeQuestion(),
                                        settings: RouteSettings(),
                                      ),
                                    ); //formpage avec 2 champs
                                  }, //ajouter les choix des themes
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.deepPurple),
                                  child: const Text(
                                      'Ajouter un thème et une question'),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _passquizz(String theme) {
    var themes = [
      "systeme solaire",
      "etoiles"
    ]; // get the themes from the database
    _visible2(); //pick a theme

    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizzPage(
          title: theme,
          theme:theme
        ),
      ),
    );*/
  }

  void quizzall() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickThemeQuizz(),
      ),
    );
  }
}
