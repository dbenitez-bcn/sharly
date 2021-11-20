import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlyapp/data/datasources/firebase_users_repository.dart';
import 'package:sharlyapp/data/models/sharly_user_model.dart';
import 'package:sharlyapp/domain/error/exeptions/sign_in_exception.dart';

import 'firebase_users_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  final mockAuth = MockFirebaseAuth();
  final FirebaseUsersRepository sut = FirebaseUsersRepository(mockAuth);
  group("Firebase users repository", () {
    test("should sign in anonymous user", () async {
      var uuid = "UUUID";
      when(mockAuth.signInAnonymously())
          .thenAnswer((_) async => mockUser(uuid));

      SharlyUserModel result = await sut.getAnonymousUser();

      expect(result.uuid, uuid);
    });

    test("when no user is sign in should fail", () async {
      final UserCredential userCredential = MockUserCredential();
      when(userCredential.user).thenReturn(null);
      when(mockAuth.signInAnonymously())
          .thenAnswer((_) async => userCredential);

      expect(sut.getAnonymousUser, throwsA(isA<SignInException>()));
    });
  });
}

UserCredential mockUser(String uuid) {
  final UserCredential userCredential = MockUserCredential();
  final User user = MockUser();
  when(userCredential.user).thenReturn(user);
  when(user.uid).thenReturn(uuid);
  return userCredential;
}
