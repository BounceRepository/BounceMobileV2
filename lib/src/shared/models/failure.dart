class Failure {
  final String message;

  Failure(this.message);
}

class InternalFailure extends Failure {
  InternalFailure() : super('Internal error');
}

class InCompleteProfileFailure extends Failure {
  InCompleteProfileFailure() : super('User does not have a profile');
}

class ConfirmEmailFailure extends Failure {
  ConfirmEmailFailure() : super('User has not confirmed email');
}
