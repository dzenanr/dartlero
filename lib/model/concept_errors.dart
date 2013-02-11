part of dartlero;

class DartleroError implements Error {

  final String msg;

  const DartleroError(this.msg);

  toString() => '*** $msg ***';

}

class JsonError extends DartleroError {

  const JsonError(String msg) : super(msg);

}

