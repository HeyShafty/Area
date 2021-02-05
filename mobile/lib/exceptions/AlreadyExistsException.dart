import 'package:area/exceptions/AreaException.dart';

class AlreadyExistsException extends AreaException {
  AlreadyExistsException({String cause = ""}) : super(cause: cause);
}
