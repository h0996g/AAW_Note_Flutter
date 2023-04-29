part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShowPasswordState extends RegisterState {}

class LodinRegisterUserState extends RegisterState {}

class RegisterUserStateGood extends RegisterState {
  RegisterUserStateGood();
}

class RegisterUserStateBad extends RegisterState {
  final err;

  RegisterUserStateBad(this.err);
}
