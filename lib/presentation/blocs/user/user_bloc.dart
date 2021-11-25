import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sharlyapp/domain/aggregates/sharly_user.dart';
import 'package:sharlyapp/services/auth_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService _service;

  UserBloc(AuthService service)
      : _service = service,
        super(UserAuthFailed()) {
    on<UserSignedIn>(_onSignIn);
  }

  void _onSignIn(UserEvent event, Emitter<UserState> emit) async {
    emit(UserAuthInProgress());
    var user = await _service.signIn();
    emit(user.fold(_fail, _success));
  }

  UserState _fail(_) {
    return UserAuthFailed();
  }

  UserState _success(SharlyUser user) {
    return UserAuthSuccess(user);
  }
}
