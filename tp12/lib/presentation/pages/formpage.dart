import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormPage();
}

class _FormPage extends State<FormPage> {
  TextEditingController _gettheme = TextEditingController();
  TextEditingController _getquestion = TextEditingController();

  _FormPage();
  @override
  Widget build(BuildContext context) {
    final i = ModalRoute.of(context)!.settings.arguments;
    final theme = ModalRoute.of(context)!.settings.arguments;

    switch (i) {
      case 0:
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
              children: [],
            )));
        break;
      case 1:
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: Text(
                " Ajouter une question",
                textAlign: TextAlign.center,
              ),
            ),
            body: Center(
                child: Stack(
              children: [],
            )));
        break;
      case 2:
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: Text(
                " Ajouter un thème et une question",
                textAlign: TextAlign.center,
              ),
            ),
            body: Center(
                child: Stack(
              children: [],
            )));
        break;
      default:
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: Text(
                " Ajouter un thème et une question",
                textAlign: TextAlign.center,
              ),
            ),
            body: Center(
                child: Stack(
              children: [
                Positioned(child: TextField(controller: _gettheme)),
                Positioned(child: TextField(controller: _getquestion)),
                Positioned(
                    child: ElevatedButton(
                  onPressed: () => {},
                  child: Text("Ajouter"),
                )),
              ],
            )));
        break;
    }
  }

  void posttvalues(int i, String theme) {
    if (theme == null) {}
  }
}
