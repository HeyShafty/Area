import 'package:area/area_services/option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  Option getActionOption(String actionValue);

  Option getReactionOption(String reactionValue);
}

class BaseState<Page extends BasePage> extends State<Page> {
  final List<Option> actions;
  final List<Option> reactions;
  final Map<String, String> params;
  final bool isAction;
  Option selectedOption;

  BaseState(this.params, this.isAction, this.actions, this.reactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(),
    );
  }

  Widget body() {
    return Column(children: [
      if (this.isAction) this.showOptions(this.actions) else this.showOptions(this.reactions),
      if (this.selectedOption != null) this.showInputs(this.selectedOption)
    ]);
  }

  Widget showInputs(Option selectedAction) {
    return Column(
        children: selectedAction.inputs.map<Widget>((e) {
      return Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Container(
              width: double.infinity,
              child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: e.hintText,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      this.params.remove(e.name);
                    } else {
                      this.params[e.name] = value;
                    }
                  })));
    }).toList());
  }

  Widget showOptions(List<Option> options) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0), color: Colors.white, border: Border.all(width: 2.0, color: Colors.grey)),
            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
            width: 200.0,
            child: DropdownButtonHideUnderline(
                child: DropdownButton<Option>(
                    value: this.selectedOption,
                    items: options.map((e) => DropdownMenuItem(child: Text(e.name), value: e)).toList(),
                    onChanged: (value) {
                      if (this.isAction) {
                        this.params[ACTION_KEY] = value.name;
                      } else {
                        this.params[REACTION_KEY] = value.name;
                      }
                      this.setState(() {
                        this.selectedOption = value;
                      });
                    }))));
  }
}
