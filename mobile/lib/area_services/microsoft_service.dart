import 'i_service.dart';

class MicrosoftService implements IService {
  static IService create() {
    return MicrosoftService();
  }

  @override
  selectAction() {
    // TODO: implement selectActionOption
    throw UnimplementedError();
  }

  @override
  selectReaction() {
    // TODO: implement selectReactionOption
    throw UnimplementedError();
  }

  @override
  getActionValue() {
    // TODO: implement getActionValue
    throw UnimplementedError();
  }

  @override
  getReactionValue() {
    // TODO: implement getReactionValue
    throw UnimplementedError();
  }
}
