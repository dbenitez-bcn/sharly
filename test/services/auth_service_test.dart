import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlyapp/data/models/sharly_user_model.dart';
import 'package:sharlyapp/data/repositories/users_repository.dart';
import 'package:sharlyapp/domain/aggregates/sharly_user.dart';
import 'package:sharlyapp/domain/error/exeptions/sign_in_exception.dart';
import 'package:sharlyapp/domain/error/failures/sign_in_failure.dart';
import 'package:sharlyapp/services/auth_service.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([UsersRepository])
void main() {
  final mockUserRepository = MockUsersRepository();
  final AuthService sut = AuthService(mockUserRepository);

  group("Auth service", () {
    test("Should return the user", () async {
      when(mockUserRepository.getAnonymousUser()).thenAnswer((_) async => SharlyUserModel("UUID"));

      Either<SignInFailure, SharlyUser> result = await sut.signIn();

      expect(result, equals(Right(SharlyUser("UUID"))));
    });

    test("Should return a failure when sign in fails", () async {
      when(mockUserRepository.getAnonymousUser()).thenThrow(SignInException());

      Either<SignInFailure, SharlyUser> result = await sut.signIn();

      expect(result, equals(Left(SignInFailure())));
    });
  });
}
