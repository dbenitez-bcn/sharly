import 'package:flutter_test/flutter_test.dart';
import 'package:sharlyapp/data/datasources/firebase_lists_repository.dart';
import 'package:sharlyapp/data/models/sharly_user_model.dart';

void main() {
  group("Firebase lists repository", () {

    final FirebaseListsRepository sut = FirebaseListsRepository();
    final SharlyUserModel aUser = SharlyUserModel("UUID");

    test("given a user should return lists", () async {
      var result = await sut.getListsByUser(aUser);

      expect(result, contains([]));
    });
  });
}
