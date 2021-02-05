import 'package:area/exceptions/AreaException.dart';

class BadTokenException extends AreaException {
  BadTokenException({String cause = ""}) : super(cause: cause);
}
