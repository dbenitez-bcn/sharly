part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserAuthFailed extends UserState {
  @override
  List<Object?> get props => [];}

class UserAuthInProgress extends UserState {
  @override
  List<Object?> get props => [];
}

class UserAuthSuccess extends UserState {
  final SharlyUser user;

  UserAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}
