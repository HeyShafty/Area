import 'package:area/exceptions/AreaException.dart';

class WrongEmailPasswordCombination extends AreaException {
  WrongEmailPasswordCombination({String cause = ""}) : super(cause: cause);
}
