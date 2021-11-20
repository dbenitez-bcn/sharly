import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharlyapp/data/models/sharly_user_model.dart';
import 'package:sharlyapp/data/repositories/users_repository.dart';
import 'package:sharlyapp/domain/error/exeptions/sign_in_exception.dart';

class FirebaseUsersRepository implements UsersRepository {
  final FirebaseAuth _firebase;


  FirebaseUsersRepository(this._firebase);

  @override
  Future<SharlyUserModel> getAnonymousUser() async {
    UserCredential credentials = await _firebase.signInAnonymously();
    if (credentials.user == null) {
      throw SignInException();
    }
    return SharlyUserModel(credentials.user!.uid);
  }

}