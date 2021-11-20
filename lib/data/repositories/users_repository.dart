import 'package:sharlyapp/data/models/sharly_user_model.dart';

abstract class UsersRepository {
  Future<SharlyUserModel> getAnonymousUser();
}