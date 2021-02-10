import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'base_page.dart';
import 'input.dart';
import 'option.dart';

class GoogleService extends BasePage {
  final Map<String, String> params;
  final bool isAction;

  GoogleService({Key key, @required this.params, @required this.isAction}) : super(key: key);

  static create(Map<String, String> params, bool isAction) {
    return GoogleService(
      params: params,
      isAction: isAction,
    );
  }

  @override
  _GoogleServiceState createState() => _GoogleServiceState(params, isAction);
}

class _GoogleServiceState extends BaseState<GoogleService> {
  static const List<Option> ACTIONS = [
    Option("new_video", [Input("channel", "Superflame")]),
    Option("playlist_update", [Input("playlist", "Playlist")])
  ];
  static const List<Option> REACTIONS = [];

  final Map<String, String> _params;
  final bool _isAction;
  Option _selectedOption;

  _GoogleServiceState(this._params, this._isAction);

  Widget showInputs(Option selectedAction) {
    return Column(
        children: selectedAction.inputs.map<Widget>((e) {
      return Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: e.hintText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              onChanged: (value) {
                this._params[e.name] = value;
              }));
    }).toList());
  }

  Widget showOptions(List<Option> options) {
    return DropdownButton<Option>(
        value: this._selectedOption,
        items: options.map((e) => DropdownMenuItem(child: Text(e.name), value: e)).toList(),
        onChanged: (value) {
          if (this._isAction) {
            this._params[ACTION_KEY] = value.name;
          } else {
            this._params[REACTION_KEY] = value.name;
          }
          this.setState(() {
            this._selectedOption = value;
          });
        });
  }

  @override
  Widget body() {
    return Column(children: [
      if (this._isAction) this.showOptions(ACTIONS) else this.showOptions(REACTIONS),
      if (this._selectedOption != null) this.showInputs(this._selectedOption)
    ]);
  }
}
