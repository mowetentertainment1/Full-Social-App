import 'package:social_app/models/user_model.dart';

abstract class RegistrationStates {}

class InitialStates extends RegistrationStates {}

class ChangeSuffixIconState extends RegistrationStates {}

class RegisterLoadingState extends RegistrationStates {}

class RegisterSuccessfullyState extends RegistrationStates {}

class RegisterErrorState extends RegistrationStates {
  final dynamic error;

  RegisterErrorState({required this.error});
}

class LoginLoadingState extends RegistrationStates {}

class LoginSuccessfullyState extends RegistrationStates {
  final String uId;

  LoginSuccessfullyState({required this.uId});
}

class LoginErrorState extends RegistrationStates {
  final dynamic error;

  LoginErrorState({required this.error});
}

class CreateUserLoadingState extends RegistrationStates {}

class CreateUserSuccessfullyState extends RegistrationStates {}

class CreateUserErrorState extends RegistrationStates {
  final dynamic error;

  CreateUserErrorState({required this.error});
}

// class ChangeFormFieldHeightState extends RegistrationStates {}
