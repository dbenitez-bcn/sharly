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
  
  void increaseQuantity(Product product) async {
    if (state is ListSelectSuccess) {
      String listId = (state as ListSelectSuccess).currentList.id;
      await FirebaseFirestore.instance.doc("lists/$listId/products/${product.id}").update({
        "quantity": product.quantity + 1,
      });
    }
  }

  void removeProduct(String documentId) {
      String id = (state as ListSelectSuccess).currentList.id;
      FirebaseFirestore
          .instance
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

  Product _mapToProduct(QueryDocumentSnapshot<Map<String, dynamic>> e) =>
      Product.fromMap(e.id, e.data());
}
