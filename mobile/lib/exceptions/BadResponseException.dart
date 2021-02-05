import 'package:area/exceptions/AreaException.dart';

class BadResponseException extends AreaException {
  BadResponseException({String cause = ""}) : super(cause: cause);
}
