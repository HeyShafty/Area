import 'dart:async';

import 'package:area/area_services/input.dart';
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
  final StreamController<Map<String, String>> streamParams;
  final Map<String, String> _params = Map();
  final bool isAction;
  Option _selectedOption;

  BaseState(this.streamParams, this.isAction, this.actions, this.reactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(),
    );
  }

  Widget body() {
    return Column(children: [
      if (this.isAction) this.showOptions(this.actions) else this.showOptions(this.reactions),
      if (this._selectedOption != null) this.showInputs(this._selectedOption)
    ]);
  }

  Widget showInputs(Option selectedAction) {
    return Column(
        children: selectedAction.inputs.map<Widget>((input) {
      return Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Container(
              width: double.infinity,
              child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorText: this.getErrorText(input, this._params[input.name]),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: input.hintText,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      this.setState(() {
                        this._params.remove(input.name);
                      });
                      this.streamParams.add(this._params);
                      return;
                    } else {
                      this.setState(() {
                        this._params[input.name] = value;
                      });
                    }
                    if (this.getErrorText(input, value) == null) {
                      this.streamParams.add(this._params);
                    }
                  })));
    }).toList());
  }

  String getErrorText(Input input, String value) {
    if (value == null || input.regex == null) {
      return null;
    }
    if (RegExp(input.regex).hasMatch(value) == false) {
      return "Invalid field.";
    }
    return null;
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
                    value: this._selectedOption,
                    items: options.map((e) => DropdownMenuItem(child: Text(e.name), value: e)).toList(),
                    onChanged: (value) {
                      if (this.isAction) {
                        this._params[ACTION_KEY] = value.name;
                      } else {
                        this._params[REACTION_KEY] = value.name;
                      }
                      this.setState(() {
                        this._selectedOption = value;
                      });
                      this.streamParams.add(this._params);
                    }))));
  }
}
