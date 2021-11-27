import 'package:sharlyapp/data/models/sharly_user_model.dart';

abstract class ListsRepository {
  Stream<List<String>> getListsByUser(SharlyUserModel user);
  // Stream<SharlyListModel> getList(String listId);
}
