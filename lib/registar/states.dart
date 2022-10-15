abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String message;
  RegisterErrorState({required this.message});
}