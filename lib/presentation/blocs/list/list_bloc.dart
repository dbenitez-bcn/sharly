import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
        "created_at": FieldValue.serverTimestamp(),
      });
    }
  }
}
