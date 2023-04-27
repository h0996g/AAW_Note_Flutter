abstract class LoginState {}

class LoginInitial extends LoginState {}

class ShowPasswordState extends LoginState {}

class ChangeIndexStateGood extends LoginState {}

class LodinLoginUserState extends LoginState {}

class LoginResponsableStateGood extends LoginState {
  final token;

  LoginResponsableStateGood(this.token);
}

class LoginResponsableStateBad extends LoginState {
  final err;

  LoginResponsableStateBad(this.err);
}

class LoginEnsiengnantStateGood extends LoginState {
  final token;

  LoginEnsiengnantStateGood(this.token);
}

class LoginEnsiengnantStateBad extends LoginState {
  final err;

  LoginEnsiengnantStateBad(this.err);
}

class LoginEtudientStateGood extends LoginState {
  final token;

  LoginEtudientStateGood(this.token);
}

class LoginEtudientStateBad extends LoginState {
  final err;

  LoginEtudientStateBad(this.err);
}
