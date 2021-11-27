import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharlyapp/data/models/sharly_user_model.dart';

class FirebaseListsRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Stream<SharedLists>> getListsByUser(SharlyUserModel user) async {
    var document = firestore.collection("shared_lists").doc(user.uuid);
    if ((await document.get()).exists) {
      return document.snapshots().map((event) => SharedLists.fromMap(event.data()!));
    } else {
      throw SnapshotNotFound();
    }
  }
}

class SharedLists {
  List<String> lists;

  SharedLists(this.lists);

  SharedLists.fromMap(Map<String, dynamic> map) : lists = map["list"];
}

class SnapshotNotFound implements Exception {}
