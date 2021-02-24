import 'package:area/dashboard.dart';
import 'package:area/profile.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'login.dart';
import 'about.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  final AreaService areaServiceInstance = AreaService();
  final List<Widget> _children = [
    DashboardPage(),
    MyProfilePage(),
    AboutPage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: _selectedIndex == 1
            ? <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () => this.signOut(),
                      icon: Icon(Icons.logout)),
                )
              ]
            : <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () => this.goToAboutPage(),
                      icon: Icon(Icons.info_outline)),
                )
              ],
        title: Text('Area'),
      ),
      body: this._children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  signOut() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await SharedPreferencesService.clearValueByKey(TOKEN_KEY);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false);
                },
                child: Text('Yes')),
          ],
        );
      },
    );
  }

  goToAboutPage() async {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => AboutPage()));
  }
}
