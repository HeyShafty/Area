import 'dart:developer';

import 'package:area/area_form.dart';
import 'package:area/services/area_service.dart';
import 'package:area/services/toast_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'exceptions/bad_token_exception.dart';
import 'models/area.dart';

class UpdateAreaFormPage extends AreaFormPage {
  final AreaService _areaServiceInstance;
  final Area area;

  UpdateAreaFormPage(this.area, [AreaService areaService]) : _areaServiceInstance = areaService ?? AreaService();

  @override
  _UpdateAreaFormPageState createState() => _UpdateAreaFormPageState(area, _areaServiceInstance);
}

class _UpdateAreaFormPageState extends AreaFormPageState<UpdateAreaFormPage> {
  _UpdateAreaFormPageState(Area area, AreaService areaService) : super(areaService) {
    if (area == null) {
      return;
    }
    SERVICES_INFORMATION_MAP.forEach((key, value) {
      if (area.action.service.toLowerCase() == value.name.toLowerCase()) {
        Map<String, dynamic> params = Map();

        params[ACTION_KEY] = area.action.name;
        if (area.action.data != null) {
          params.addAll(area.action.data);
        }
        this.selectedActionServiceInfo = value;
        this.actionService = value.createServiceInstance(this.actionParamsController, true, params);
      }
      if (area.reaction.service.toLowerCase() == value.name.toLowerCase()) {
        Map<String, dynamic> params = Map();

        params[REACTION_KEY] = area.reaction.name;
        if (area.reaction.data != null) {
          params.addAll(area.reaction.data);
        }
        this.selectedReactionServiceInfo = value;
        this.reactionService = value.createServiceInstance(this.reactionParamsController, false, params);
      }
    });
  }

  @override
  Widget getFormTitle() {
    return Text('Update Area');
  }

  @override
  onButtonPressed() async {
    Area area = Area("", AreaAction(this.selectedActionServiceInfo.name.toLowerCase(), this.actionParams[ACTION_KEY], this.actionParams),
        AreaReaction(this.selectedReactionServiceInfo.name.toLowerCase(), this.reactionParams[REACTION_KEY], this.reactionParams));

    try {
      await this.areaServiceInstance.addArea(area);
      ToastService.showToast("Area updated successfully!", Colors.green);
      return Navigator.pop(context);
    } on BadTokenException {
      ToastService.showToast("Invalid token, please sign out.");
    } on Exception catch (e) {
      log(e.toString());
      ToastService.showToast("Couldn't update area.");
    } catch (e) {
      log(e.toString());
      ToastService.showToast("Couldn't update area.");
    }
    this.buttonController.reset();
  }
}
