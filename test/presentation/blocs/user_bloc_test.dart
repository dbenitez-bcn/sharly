import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlyapp/domain/aggregates/sharly_user.dart';
import 'package:sharlyapp/domain/error/failures/sign_in_failure.dart';
import 'package:sharlyapp/presentation/blocs/user/user_bloc.dart';
import 'package:sharlyapp/services/auth_service.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  group("User bloc", () {
    MockAuthService authService = MockAuthService();
    blocTest<UserBloc, UserState>(
      "should emit UserAuthenticationSuccess",
      build: () => UserBloc(authService),
      act: (bloc) {
        when(authService.signIn())
            .thenAnswer(((_) async => Right(SharlyUser("UUID"))));
        bloc.add(UserSignedIn());
      },
      expect: () =>
      <UserState>[
        UserAuthInProgress(),
        UserAuthSuccess(SharlyUser("UUID"))
      ],
    );

    blocTest<UserBloc, UserState>(
      "should emit UserAuthenticationSuccess",
      build: () => UserBloc(authService),
      act: (bloc) {
        when(authService.signIn())
            .thenAnswer(((_) async => Left(SignInFailure())));
        bloc.add(UserSignedIn());
      },
      expect: () =>
      <UserState>[
        UserAuthInProgress(),
        UserAuthFailed()
      ],
    );
  });
}