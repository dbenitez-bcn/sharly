part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserSignedIn extends UserEvent {}
