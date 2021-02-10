import 'package:flutter/cupertino.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(),
    );
  }

  Widget body();
}
