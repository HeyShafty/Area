import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState<Page extends AboutPage> extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: this.getFormTitle(),
        ),
        body: SingleChildScrollView(
            child: Column(children: [DescriptionCard()])));
  }

  Widget getFormTitle() {
    return Text('About ChadArea');
  }
}

class DescriptionCard extends StatelessWidget {
  DescriptionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(24.0),
        elevation: 5,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(' Project Overview',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.only(bottom: 15.0)),
            Text('Epitech 3rd year final project.',
                style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center),
            Text('(20/01/21 - 07/03/21).',
                style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
                'This project consists in the creation of a software suite that functions similarly to IFTTT / Zapier.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
                'You are using the mobile version of ChadArea, which was developed in Flutter and uses our server created using NodeJs & MongoDb.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Text(
                'For more detailed information about the project, please refer to the documentation provided in the official Github page of the project.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center),
            Padding(padding: EdgeInsets.only(top: 10.0)),
          ],
        ),
      ),
    );
  }
}
