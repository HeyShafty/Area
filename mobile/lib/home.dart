import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AreaService areaServiceInstance = AreaService();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Text('MDR'),
    ));
  }
}
