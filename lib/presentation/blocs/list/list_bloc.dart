import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sharlyapp/domain/valueObjects/product.dart';
import 'package:sharlyapp/domain/valueObjects/shared_list.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const ListInitState()) {
    on<ListChangedEvent>((event, emit) {
      emit(ListSelectSuccess(event.selectedList));
    });
  }

  Future<void> addList(String uid, String title) async {
    DocumentReference newList =
        await FirebaseFirestore.instance.collection("lists").add({
      "title": title,
      "created_at": FieldValue.serverTimestamp(),
    });
    await FirebaseFirestore.instance.collection("shared_lists").doc(uid).set({
      "lists": FieldValue.arrayUnion([newList.id])
    });

    add(ListChangedEvent(await _getSharedListById(newList.id)));
  }

  void addProduct(String title) {
    if (state is ListSelectSuccess) {
      String id = (state as ListSelectSuccess).currentList.id;
      FirebaseFirestore.instance.collection("lists/$id/products").add({
        "title": title,
        "quantity": 1,
        "created_at": FieldValue.serverTimestamp(),
      });
    }
  }

  void updateProduct(Product product) async {
    if (state is ListSelectSuccess) {
      String listId = (state as ListSelectSuccess).currentList.id;
      await FirebaseFirestore.instance
          .doc("lists/$listId/products/${product.id}")
          .update({
        "title": product.title,
        "quantity": product.quantity,
      });
    }
  }

  void increaseQuantity(Product product) async {
    if (state is ListSelectSuccess) {
      String listId = (state as ListSelectSuccess).currentList.id;
      await FirebaseFirestore.instance
          .doc("lists/$listId/products/${product.id}")
          .update({
        "quantity": product.quantity + 1,
      });
    }
  }

  void removeProduct(String documentId) {
    String id = (state as ListSelectSuccess).currentList.id;
    FirebaseFirestore.instance
        .collection("lists/$id/products")
        .doc(documentId)
        .delete();
  }

  Stream<List<Product>> getProducts() {
    String id = (state as ListSelectSuccess).currentList.id;
    return FirebaseFirestore.instance
        .collection("lists/$id/products")
        .snapshots()
        .map((event) => event.docs.map(_mapToProduct).toList());
  }

  Future<List<SharedList>> getListsByUserId(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("shared_lists")
        .doc(uid)
        .get();

    List<String> listsId = List<String>.from(snapshot.data()!["lists"]);

    List<SharedList> lists = [];
    for (String id in listsId) {
      lists.add(await _getSharedListById(id));
    }

    return lists;
  }

  Future<SharedList> _getSharedListById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> listDocument =
        await FirebaseFirestore.instance.collection("lists").doc(id).get();

    return SharedList(listDocument.id, listDocument.data()!["title"]);
  }

  Product _mapToProduct(QueryDocumentSnapshot<Map<String, dynamic>> e) =>
      Product.fromMap(e.id, e.data());
}
