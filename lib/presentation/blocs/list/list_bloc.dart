import 'package:bloc/bloc.dart';
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
}
