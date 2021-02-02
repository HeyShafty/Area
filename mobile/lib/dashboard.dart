import 'package:area/services/area_service.dart';
import 'package:flutter/cupertino.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  final AreaService areaServiceInstance = AreaService();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Text('MDR'),
    ));
  }
}
